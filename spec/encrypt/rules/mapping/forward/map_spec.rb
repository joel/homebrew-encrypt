module Encrypt
  module Rules
    module Mapping
      module Forward
        RSpec.describe Map do
          describe '.call' do
            let(:input)  { '189' }
            let(:output) { '680' }
            it do
              expect(described_class.call(input)).to eql(output)
            end
          end
        end
      end
    end
  end
end
