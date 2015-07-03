require 'holder'

describe 'Holder' do
  let(:test_holder) { Holder.new('Robert Pulson', 0) }

  context 'when initialised' do
    it 'has a name' do
      expect(test_holder.name).to eq('Robert Pulson')
    end

    it 'has an id' do
      expect(test_holder.id).to eq(0)
    end
  end
end