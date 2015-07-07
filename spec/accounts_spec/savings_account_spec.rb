require 'accounts/savings_account'

describe 'SavingsAccount' do
  context 'when initialised' do
    let(:test_holder)  { double :test_holder                }
    let(:test_account) { SavingsAccount.new(test_holder, 1) }

    it 'can initialise with the correct type' do
      expect(test_account.type).to be(:Savings)
    end

    it 'has the correct limit' do
      expect(test_account.limit).to eq(300)
    end
  end
end
