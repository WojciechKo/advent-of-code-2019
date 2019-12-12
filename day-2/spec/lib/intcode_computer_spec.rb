require 'intcode_computer'

RSpec.describe IntcodeComputer do
  describe '::part_1' do
    subject     { described_class.part_1(input, noun: noun, verb: verb) }
    let(:input) { File.read('input') }
    let(:noun)  { 12 }
    let(:verb)  { 2 }

    context 'with some data alteration' do
      it 'writes output to the file' do
        File.write('output-part1', subject)
      end

      it 'checks if correct result' do
        expect(subject).to eq(9_706_670)
      end
    end
  end

  describe '::part_2' do
    subject     { described_class.part_2(input, output: 19_690_720) }
    let(:input) { File.read('input') }

    context 'with some data alteration' do
      it 'writes output to the file' do
        File.write('output-part2', subject)
      end

      it 'checks if correct result' do
        expect(subject).to eq(2552)
      end
    end
  end
end
