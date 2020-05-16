module Passy
  module Rules
    RSpec.describe Digit do
      describe '.call' do
        let(:input)  { '423' }
        let(:output) { '423' }
        it do
          expect(described_class.call(input)).to eql(output)
          expect(described_class.call(output)).to eql(input)
        end
      end
    end
  end
end
