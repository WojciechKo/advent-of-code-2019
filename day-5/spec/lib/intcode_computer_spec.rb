require 'intcode_computer'

RSpec.describe IntcodeComputer do
  fdescribe '::part_1' do
    subject do
      simulate_stdin('1') do
        described_class.part_1(input)
      end
    end
    let(:input) { File.read('input') }

    context 'with some data alteration' do
      it 'writes output to the file' do
        output = with_captured_stdout { subject }
        File.write('output-part1', output)
      end

      it 'checks if correct result' do
        expect { subject }
          .to output(/9961446\n$/).to_stdout
      end
    end
  end

  xdescribe '::part_2' do
    subject { described_class.part_2(input, output: 19_690_720) }
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
