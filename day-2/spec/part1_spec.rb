require 'part1'

RSpec.describe Part1 do
  context 'with provided input file' do
    subject      { Part1::Executor.new(memory).execute }
    let(:memory) { Part1::Memory.from_string(input) }
    let(:input)  { File.read('input-part1') }

    context 'with some data alteration' do
      before do
        memory[1] = 12
        memory[2] = 2
      end

      it 'writes output to the file' do
        output = subject.first
        File.write('output-part1', output)
      end

      it 'checks if correct result' do
        expect(subject.first).to eq(9706670)
      end
    end
  end

  shared_examples 'it works as expected' do |**args|
    subject      { Part1::Executor.new(memory).execute }
    let(:memory) { Part1::Memory.from_string(input) }

    let(:input)  { args[:input] }
    let(:output) { args[:output] }

    context "with input: #{args[:input].inspect}" do
      it "matches the output: #{args[:output].inspect}" do
        expect(subject.join(',')).to eq(output)
      end
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
                  input: '1,9,10,3,2,3,11,0,99,30,40,50',
                  output: '3500,9,10,70,2,3,11,0,99,30,40,50'
end
