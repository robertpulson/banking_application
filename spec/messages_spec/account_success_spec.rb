require 'messages/message'
require 'messages/account_success'

describe 'AccountSuccessMessage' do
  context 'when initialised' do
    let(:test_account) { double :account, id: 0    }
    let(:test_message) { AccountSuccessMessage.new(test_account) }

    it 'has the correct main text' do
      expect(test_message.main[0])
        .to eq('New Account created. ID number is: 0')
    end
  end
end
