require 'messages/success_message'

describe 'SuccessMessage' do
  context 'when initialised' do
    let(:test_message) { SuccessMessage.new }

    it 'has the correct header' do
      expect(test_message.header).to eq('Transaction Successful.')
    end

    it 'has the correct colour' do
      expect(test_message.colour).to eq(:green)
    end
  end
end
