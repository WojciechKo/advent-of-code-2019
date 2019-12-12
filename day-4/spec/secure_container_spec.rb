require 'secure_container'

RSpec.describe SecureContainer do
  shared_examples 'it works as expected' do |input:, output:|
    subject { described_class.part_1(input) }

    context "with input: #{input.inspect}" do
      it { is_expected.to eq(output) }
    end
  end

  context 'with provided examples' do
    it_behaves_like 'it works as expected',
                    input: '122348-122351',
                    output: 2
  end

  describe '::part_1' do
    subject { described_class.part_1(input) }

    context 'with input file' do
      let(:input) { File.read('input') }

      it 'writes output to the file' do
        File.write('output-part1', subject)
      end

      it 'checks if the result is correct' do
        expect(subject).to eq(1729)
      end
    end
  end

  describe '::part_2' do
    subject { described_class.part_2(input) }

    context 'with input file' do
      let(:input) { File.read('input') }

      it 'writes output to the file' do
        File.write('output-part2', subject)
      end

      it 'checks if the result is correct' do
        expect(subject).to eq(1172)
      end
    end
  end
end
