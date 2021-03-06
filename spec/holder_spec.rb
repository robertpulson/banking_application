require 'holder'
# require test subject

describe 'Holder' do
  # sets up the test subject
  let(:test_holder) { Holder.new('Robert Pulson', 0) }
  # creates an instance of the test subject to run tests on

  context 'when initialised' do
    # tests inside this block will test events that take place after initialisation
    
    it 'has a name' do
      expect(test_holder.name).to eq('Robert Pulson')
    end

    it 'has an id' do
      expect(test_holder.id).to eq(0)
    end

    it 'capitalises the holders name' do
      test_holder = Holder.new('robert pulson', 0)
      expect(test_holder.name).to eq('Robert Pulson')
    end
  end
end
