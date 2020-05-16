module Passy
  module Rules
    RSpec.describe Deviance do
      describe '.call' do
        let(:input)    { '1%195bDf!g' }
        let(:output)   { '6!605BdF%G' }
        let(:deviance) { '6!105BdF%g' }
        it do
          expect(described_class.new(input).call(output)).to eql(deviance)
        end
      end
    end
  end
end
