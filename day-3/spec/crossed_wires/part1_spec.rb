require 'crossed_wires'

RSpec.describe CrossedWires::Part1 do
  subject { described_class.new.call(input) }

  context 'with input file' do
    let(:input) { File.read('input-part1') }

    it 'writes output to the file' do
      File.write('output-part1', subject)
    end

    it 'checks if the result is correct' do
      expect(subject).to eq(8015)
    end
  end

  context 'with provided examples' do
    shared_examples 'it works as expected' do |input:, output:|
      let(:input)  { input }
      let(:output) { output }

      context "with input: #{input.inspect}" do
        it { is_expected.to eq(output) }
      end
    end

    it_behaves_like 'it works as expected',
                    input: "R75,D30,R83,U83,L12,D49,R71,U7,L72\nU62,R66,U55,R34,D71,R55,D58,R83",
                    output: 159

    it_behaves_like 'it works as expected',
                    input: "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51\nU98,R91,D20,R16,D67,R40,U7,R15,U6,R7",
                    output: 135
  end
end
