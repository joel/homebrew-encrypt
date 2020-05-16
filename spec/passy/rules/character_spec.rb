module Passy
  module Rules
    RSpec.describe Character do
      describe '.call' do
        let(:input)  { 'aB' }
        let(:output) { 'Ab' }
        it do
          expect(described_class.call(input)).to eql(output)
          expect(described_class.call(output)).to eql(input)
        end
      end
    end
  end
end
