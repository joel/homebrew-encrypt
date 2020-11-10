module Encrypt
  module Rules
    module Mapping
      module Backward
        RSpec.describe Map do
          describe '.call' do
            let(:input)  { '680' }
            let(:output) { '189' }
            it do
              expect(described_class.call(input)).to eql(output)
            end
          end
        end
      end
    end
  end
end
