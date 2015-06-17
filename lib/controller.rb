# Definition of Controller Class
class Controller
  attr_reader :name, :accounts, :holders
  attr_accessor :account_number, :holder_number

  def initialize
    @account_number = 0
    @holder_number  = 0
    @accounts       = {}
    @holders        = {}
    @main_items     = { 0 => 'Create New Holder',
                        1 => 'Create Current Account',
                        2 => 'Deposit',
                        3 => 'Display Balance',
                        4 => 'Withdraw',
                        5 => 'Transfer Money',
                        6 => 'Pay Interest',
                        7 => 'Add Account Holder',
                        8 => 'Show all accounts held by a customer',
                        9 => 'View Transactions' }
    @account_types  = { 0 => 'Current',
                        1 => 'Savings',
                        2 => 'Student',
                        3 => 'Business',
                        4 => 'SMB',
                        5 => 'IR' }
  end

  def increment_account_number
    @account_number += 1
  end

  def increment_holder_number
    @holder_number += 1
  end

  def add_holder(new_holder)
    @holders[new_holder.id] = new_holder
    increment_holder_number
  end

  def add_account(new_account)
    @accounts[new_account.account_number] = new_account
    increment_account_number
  end

  def enter
    input = nil
    until input == ''
      puts "Press 'ENTER' to begin"
      input = gets.chomp
    end
  end

  def main_menu
    @main_items.each { |key, value| puts "#{key}. #{value}" }
    puts "What would you like to do?\nEnter a number and hit 'ENTER'"
    gets.chomp
  end

  def option_0
    puts 'Enter Customer Name'
    name = gets.chomp
    new_holder = Holder.new(name, @holder_number)
    add_holder(new_holder)
    puts 'Holder added!'
  end

  def option_1
    puts 'Enter customer ID'
    index = gets.chomp.to_i
    holder = @holders[index]
    puts 'Which type of account would you like to open?'
    @account_types.each { |key, value| puts "#{key}. #{value} Account" }
    input = gets.chomp.to_i
    account = create_account(input, holder)
    add_account(account)
    puts "Account Created.\nYour Account Number is: #{account.account_number}"
  end

  def selector(input)
    case input
    when 0 then option_0
    when 1 then option_1
    when 2 then option_2
    when 3 then option_3
    when 4 then option_4
    when 5 then option_5
    when 6 then option_6
    when 7 then option_7
    when 8 then option_8
    when 9 then option_9
    end
  end

  def create_account(input, holder)
    case input
    when 0 then CurrentAccount.new(holder, @account_number)
    when 1 then SavingsAccount.new(holder, @account_number)
    when 2 then StudentAccount.new(holder, @account_number)
    when 3 then BusinessAccount.new(holder, @account_number)
    when 4 then SMBAccount.new(holder, @account_number)
    when 5 then IRAccount.new(holder, @account_number)
    end
  end

  def start
    enter
    input = main_menu.to_i
    selector(input)
  end
end
