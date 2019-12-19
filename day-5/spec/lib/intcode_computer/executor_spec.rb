require 'intcode_computer/executor'

RSpec.describe IntcodeComputer::Executor do
  shared_examples 'it works as expected' do |args|
    subject(:execute) { described_class.new(intcodes_in).execute }

    let(:intcodes_in) { args[:intcodes_in] }
    let(:intcodes_out) { args[:intcodes_out] }
    let(:inputs) { args[:inputs] }
    let(:outputs) { args[:outputs] }

    context "with intcodes: #{args[:intcodes_in].inspect}" do
      it do
        simulate_stdin(*inputs) do
          expect(execute).to eq(intcodes_out)
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
end
