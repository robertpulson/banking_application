require_relative 'controller_item_store'
# Definition of Controller Class
class AccountsController
  include ControllerItemStore

  attr_reader :holders, :task_manager

  def initialize
    super
    @holders      = HoldersController.new
    @interest     = InterestController.new
    @task_manager = Rufus::Scheduler.new
  end

  def open_account(type, with:)
    return InvalidHolderMessage.new(with) unless holder = holders.exist?(with)
    new_account = create_account(type, holder)
    add new_account
    init_yearly_interest_for new_account
    AccountSuccessMessage.new(new_account)
  end

  def create_holder(name)
    holders.create_holder(name)
  end

  def deposit(amount, into:)
    return InvalidAccountMessage.new(into) unless account = exist?(into)
    account.deposit amount
    DepositSuccessMessage.new(amount)
  end

  def withdraw(amount, from:)
    return InvalidAccountMessage.new(from) unless account = exist?(from)
    return InsufficientFundsMessage.new(account) unless check_balance_of account, with: amount
    return OverLimitMessage.new(account) if check_limit_of account, with: amount
    init_limit_reset_for account unless account.under_limit?
    account.withdraw amount
    WithdrawSuccessMessage.new(amount)
  end

  def get_balance_of(account_id)
    return InvalidAccountMessage.new(account_id) unless account = exist?(account_id)
    BalanceMessage.new(account)
  end

  def transfer(amount, from:, to:)
    return InvalidAccountMessage.new(from) unless donar = exist?(from)
    return InvalidAccountMessage.new(to) unless recipitent = exist?(to)
    return InsufficientFundsMessage.new(donar) unless check_balance_of donar, with: amount
    return OverLimitMessage.new(donar) if check_limit_of donar, with: amount
    donar.withdraw amount
    recipitent.deposit amount
    TransferSuccessMessage.new(amount)
  end

  def add_holder(id, to_account:)
    return InvalidHolderMessage.new(id) unless new_holder = holders.exist?(id)
    return InvalidAccountMessage.new(to_account) unless account = exist?(to_account)
    return HolderOnAccountMessage.new(new_holder, account) if check_holders_of account, with: new_holder
    account.add_holder new_holder
    AddHolderSuccessMessage.new(new_holder, account)
  end

  def get_transactions_of(account_id)
    return InvalidAccountMessage.new(account_id) unless account = exist?(account_id)
    transactions = account.transactions
    TransactionsMessage.new(transactions)
  end

  def get_accounts_of(holder_id)
    return InvalidHolderMessage.new(holder_id) unless holder = holders.exist?(holder_id)
    accounts = store.select { |_, a| a.main_holder == holder }.values
    DisplayAccountsMessage.new(accounts)
  end

  def reset_limit_on(account)
    account.reset_limit
  end

  def pay_interest_on(account)
    amount = @interest.calculate_interest_on account
    account.deposit amount
  end

  ACCOUNT_CLASSES = { :Current      => CurrentAccount,
                      :Savings      => SavingsAccount,
                      :Business     => BusinessAccount,
                      :IR           => IRAccount,
                      :SMB          => SMBAccount,
                      :Student      => StudentAccount,
                      :HighInterest => HighInterestAccount,
                      :Islamic      => IslamicAccount,
                      :Private      => PrivateAccount,
                      :LCR          => LCRAccount          }

  private

  def init_yearly_interest_for(account)
    @task_manager.every '1y' do pay_interest_on account end
  end

  def init_limit_reset_for(account)
    @task_manager.in '1d' do reset_limit_on account end
  end

  def check_holders_of(account, with:)
    account.main_holder == with || account.holders.value?(with)
  end

  def check_balance_of(account, with:)
    account.balance >= with
  end

  def check_limit_of(account, with:)
    with > account.daily_limit
  end

  def create_account(type, holder)
    account_class = ACCOUNT_CLASSES[type]
    account_class.new(holder, current_id)
  end
end
