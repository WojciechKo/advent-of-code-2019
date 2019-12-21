require 'intcode_computer/executor'

RSpec.describe IntcodeComputer::Executor do
  shared_examples 'it works as expected' do |args|
    subject(:execute) { described_class.new(intcodes_in).execute }

    let(:intcodes_in) { args[:intcodes_in] }
    let(:intcodes_out) { args[:intcodes_out] }
    let(:inputs) { args[:inputs] }
    let(:outputs) { args[:outputs] }

    context "with intcodes: #{args[:intcodes_in].inspect}" do
      if args[:intcodes_out]
        it do
          simulate_stdin(*inputs) do
            expect(execute).to eq(intcodes_out)
          end
        end
      end

      if args[:outputs]
        it do
          expect do
            simulate_stdin(*inputs) { execute }
          end.to output(outputs).to_stdout
        end
      end
    end
  end

  it_behaves_like 'it works as expected',
                  intcodes_in: [1, 0, 0, 0, 99],
                  intcodes_out: [2, 0, 0, 0, 99]

  it_behaves_like 'it works as expected',
                  intcodes_in: [2, 3, 0, 3, 99],
                  intcodes_out: [2, 3, 0, 6, 99]

  it_behaves_like 'it works as expected',
                  intcodes_in: [2, 4, 4, 5, 99, 0],
                  intcodes_out: [2, 4, 4, 5, 99, 9801]

  it_behaves_like 'it works as expected',
                  intcodes_in: [1, 1, 1, 4, 99, 5, 6, 0, 99],
                  intcodes_out: [30, 1, 1, 4, 2, 5, 6, 0, 99]

  it_behaves_like 'it works as expected',
                  intcodes_in: [1, 9, 10, 3, 2, 3, 11, 0, 99, 30, 40, 50],
                  intcodes_out: [3500, 9, 10, 70, 2, 3, 11, 0, 99, 30, 40, 50]

  it_behaves_like 'it works as expected',
                  intcodes_in: [3, 0, 4, 0, 99],
                  inputs: ['69'],
                  intcodes_out: [69, 0, 4, 0, 99],
                  outputs: "69\n"

  it_behaves_like 'it works as expected',
                  intcodes_in: [3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8],
                  inputs: ['7'],
                  outputs: "0\n"

  it_behaves_like 'it works as expected',
                  intcodes_in: [3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8],
                  inputs: ['8'],
                  outputs: "1\n"

  it_behaves_like 'it works as expected',
                  intcodes_in: [3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8],
                  inputs: ['9'],
                  outputs: "0\n"

  it_behaves_like 'it works as expected',
                  intcodes_in: [3, 9, 7, 9, 10, 9, 4, 9, 99, -1, 8],
                  inputs: ['7'],
                  outputs: "1\n"

  it_behaves_like 'it works as expected',
                  intcodes_in: [3, 9, 7, 9, 10, 9, 4, 9, 99, -1, 8],
                  inputs: ['8'],
                  outputs: "0\n"

  it_behaves_like 'it works as expected',
                  intcodes_in: [3, 9, 7, 9, 10, 9, 4, 9, 99, -1, 8],
                  inputs: ['9'],
                  outputs: "0\n"

  it_behaves_like 'it works as expected',
                  intcodes_in: [3, 3, 1108, -1, 8, 3, 4, 3, 99],
                  inputs: ['7'],
                  outputs: "0\n"

  it_behaves_like 'it works as expected',
                  intcodes_in: [3, 3, 1108, -1, 8, 3, 4, 3, 99],
                  inputs: ['8'],
                  outputs: "1\n"

  it_behaves_like 'it works as expected',
                  intcodes_in: [3, 3, 1108, -1, 8, 3, 4, 3, 99],
                  inputs: ['9'],
                  outputs: "0\n"

  it_behaves_like 'it works as expected',
                  intcodes_in: [3, 3, 1107, -1, 8, 3, 4, 3, 99],
                  inputs: ['7'],
                  outputs: "1\n"

  it_behaves_like 'it works as expected',
                  intcodes_in: [3, 3, 1107, -1, 8, 3, 4, 3, 99],
                  inputs: ['8'],
                  outputs: "0\n"

  it_behaves_like 'it works as expected',
                  intcodes_in: [3, 3, 1107, -1, 8, 3, 4, 3, 99],
                  inputs: ['9'],
                  outputs: "0\n"

  it_behaves_like 'it works as expected',
                  intcodes_in: [3, 12, 6, 12, 15, 1, 13, 14, 13, 4, 13, 99, -1, 0, 1, 9],
                  inputs: ['0'],
                  outputs: "0\n"

  it_behaves_like 'it works as expected',
                  intcodes_in: [3, 12, 6, 12, 15, 1, 13, 14, 13, 4, 13, 99, -1, 0, 1, 9],
                  inputs: ['420'],
                  outputs: "1\n"

  it_behaves_like 'it works as expected',
                  intcodes_in: [3, 3, 1105, -1, 9, 1101, 0, 0, 12, 4, 12, 99, 1],
                  inputs: ['0'],
                  outputs: "0\n"

  it_behaves_like 'it works as expected',
                  intcodes_in: [3, 3, 1105, -1, 9, 1101, 0, 0, 12, 4, 12, 99, 1],
                  inputs: ['420'],
                  outputs: "1\n"
end
