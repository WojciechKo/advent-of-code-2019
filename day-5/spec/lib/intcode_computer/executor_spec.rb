require 'intcode_computer/executor'

RSpec.describe IntcodeComputer::Executor do
  shared_examples 'it works as expected' do |input:, output:|
    subject      { described_class.new(memory).execute }
    let(:memory) { IntcodeComputer::Memory.new(input) }

    context "with input: #{input.inspect}" do
      it { is_expected.to eq(output) }
    end
  end

  it_behaves_like 'it works as expected',
                  input: [1, 0, 0, 0, 99],
                  output: [2, 0, 0, 0, 99]

  it_behaves_like 'it works as expected',
                  input: [2, 3, 0, 3, 99],
                  output: [2, 3, 0, 6, 99]

  it_behaves_like 'it works as expected',
                  input: [2, 4, 4, 5, 99, 0],
                  output: [2, 4, 4, 5, 99, 9801]

  it_behaves_like 'it works as expected',
                  input: [1, 1, 1, 4, 99, 5, 6, 0, 99],
                  output: [30, 1, 1, 4, 2, 5, 6, 0, 99]

  it_behaves_like 'it works as expected',
                  input: [1, 9, 10, 3, 2, 3, 11, 0, 99, 30, 40, 50],
                  output: [3500, 9, 10, 70, 2, 3, 11, 0, 99, 30, 40, 50]
end
