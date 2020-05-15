module Passy
  RSpec.describe Encryptor do
    describe '#encrypt' do
      let(:input)  { 'a' }
      let(:output) { 'a' }
      it do
        expect(subject.encrypt(input)).to eql(output)
      end
    end
  end
end
