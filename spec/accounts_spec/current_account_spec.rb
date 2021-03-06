require 'accounts/current_account'

describe 'CurrentAccount' do
  context 'when initialised' do
    let(:test_holder)  { double :test_holder                }
    let(:test_account) { CurrentAccount.new(test_holder, 1) }

    it 'it has the correct type' do
      expect(test_account.type).to be(:Current)
    end
  end
end
