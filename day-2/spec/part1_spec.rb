require_relative '../part1'

RSpec.describe Part1 do
  context 'with provided input file' do
    let(:input) { File.read('input') }

    it 'prints output' do
      puts Part1.new(input).call
    end
  end

  shared_examples 'it works as expected' do |**args|
    subject { Part1.new(input).call }

    let(:input) { args[:input] }
    let(:output) { args[:output] }

    context "with input: #{args[:input].inspect}" do
      it { is_expected.to eq(output) }
    end
  end

  it_behaves_like 'it works as expected',
    input: '1,0,0,0,99',
    output: '2,0,0,0,99'

  it_behaves_like 'it works as expected',
    input: '2,3,0,3,99',
    output: '2,3,0,6,99'

  it_behaves_like 'it works as expected',
    input: '2,4,4,5,99,0',
    output: '2,4,4,5,99,9801'

  it_behaves_like 'it works as expected',
    input: '1,1,1,4,99,5,6,0,99',
    output: '30,1,1,4,2,5,6,0,99'

  it_behaves_like 'it works as expected',
    input:'1,9,10,3,2,3,11,0,99,30,40,50',
    output: '3500,9,10,70,2,3,11,0,99,30,40,50'
end
