module Encrypt
  module Rules
    RSpec.describe Symbol do
      describe '.call' do
        let(:input)  { '%!-' }
        let(:output) { '-!%' }
        it do
          expect(described_class.call(input)).to eql(output)
          expect(described_class.call(output)).to eql(input)
        end
      end
    end
  end
end
