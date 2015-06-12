require 'account'

describe 'Account' do

  let(:holder)       { double :holder       }
  let(:test_account) { Account.new(:holder) }

  it 'has a balance' do
    expect(test_account).to respond_to(:balance)
  end

  it 'is initialsed with zero balance' do
    expect(test_account.balance).to eq(0.00)
  end

  it 'is initialsed with a holder' do
    expect(test_account.holders).to eq([:holder])
  end

  it 'can add a holder' do
    new_holder = double :new_holder
    test_account.add(:new_holder)
    expect(test_account.holders).to eq([:holder, :new_holder])
  end

  it 'can make a deposit' do
    test_account.deposit(100)
    expect(test_account.balance).to eq(100.00)
  end

  it 'can make a withdrawal' do
    test_account.deposit(100)
    test_account.withdraw(100)
    expect(test_account.balance).to eq(0)
  end

  it 'doesnt allow withdrawals over the current balance' do
    test_account.deposit(100)
    expect { test_account.withdraw(101) }.to raise_error
      ('The withdrawal amount exceeds your current balance!')
  end

  it 'has an interest rate' do
    expect(test_account).to respond_to(:interest_rate)
  end

  it 'has an account number' do
    expect(test_account).to respond_to(:account_number)
  end
end