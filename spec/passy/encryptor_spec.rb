module Passy
  RSpec.describe Encryptor do
    describe '#encrypt' do
      [
        {
          input: 'aB',
          output: 'Ab'

        },
        {
          input: '423',
          output: '423'

        },
        {
          input: '%!-',
          output: '-!%'

        },
        {
          input: '189',
          output: '680'

        },
        {
          input: '1%195bDf!g',
          output: '6!105BdF%g'

        },
      ].each do |hash|
        it do
          expect(subject.encrypt(password: hash[:input])).to eql(hash[:output])
        end
        it do
          expect(subject.decrypt(encrypted_password: hash[:output])).to eql(hash[:input])
        end
      end

    end
  end
end
