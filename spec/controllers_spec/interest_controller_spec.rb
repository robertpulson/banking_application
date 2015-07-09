require 'controllers/interest_controller'

describe 'InterestController' do
  let(:test_account)    { double :account, balance: 2500, interest_rate: 0.1 }
  let(:test_controller) { InterestController.instance }

  context 'when initialised' do
    it 'has a master account' do
      expect(test_controller.account.type).to eq(:Master)
    end
  end

  context 'when calculating interest' do
    it 'returns the interest due on an account' do
      expect(test_controller.calculate_interest_on(test_account))
        .to eq(250)
    end
  end
end
