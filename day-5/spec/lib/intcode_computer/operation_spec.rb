require 'intcode_computer/operation'
require 'intcode_computer/operation_type'

RSpec.describe IntcodeComputer::Operation do
  let(:memory) { [1, 2, 3, 4, 5, 6, 7, 8, 9] }

  describe 'wirtes to the memory' do
    subject(:operation) do
      described_class.new(
        operation_type: operation_type,
        args: [0]
      )
    end

    let(:operation_type) do
      IntcodeComputer::OperationType.new(
        opcode: 0,
        operation: -> { 420 },
        store_output: store_output
      )
    end

    context 'without storage' do
      let(:store_output) { false }

      it 'does not change memory' do
        expect { operation.call(memory) }
          .to_not change { memory }
      end
    end

    context 'without defined' do
      let(:store_output) { true }

      it 'saves output to the memory' do
        expect { operation.call(memory) }
          .to change { memory }.to(start_with(420))
      end
    end
  end

  describe 'arguments modes' do
    let(:operation_type) do
      IntcodeComputer::OperationType.new(
        opcode: 0,
        operation: ->(a, b) { [a, b] },
        store_output: true
      )
    end

    context 'without defined' do
      it 'uses position mode as default for missing modes' do
        operation = described_class.new(
          operation_type: operation_type,
          args: [3, 4, 5]
        )
        expect(operation.call(memory)).to eq([4, 5])
      end
    end

    context 'with [0, 0]' do
      let(:args_modes) { [0, 0] }

      it 'fetches all of the inputs in a position mode' do
        operation = described_class.new(
          operation_type: operation_type,
          args: [3, 4, 5],
          args_modes: args_modes
        )
        expect(operation.call(memory)).to eq([4, 5])
      end
    end

    context 'with [1]' do
      let(:args_modes) { [1] }

      it 'uses position mode as default for missing modes' do
        operation = described_class.new(
          operation_type: operation_type,
          args: [3, 4, 5],
          args_modes: args_modes
        )
        expect(operation.call(memory)).to eq([3, 5])
      end
    end

    context 'with [1, 1]' do
      let(:args_modes) { [1, 1] }

      it 'fetches all input in immediate mode' do
        operation = described_class.new(
          operation_type: operation_type,
          args: [3, 4, 5],
          args_modes: args_modes
        )
        expect(operation.call(memory)).to eq([3, 4])
      end
    end

    context 'with [1, 0]' do
      let(:args_modes) { [1, 0] }

      it 'fetches all input in immediate mode' do
        operation = described_class.new(
          operation_type: operation_type,
          args: [3, 4, 5],
          args_modes: args_modes
        )
        expect(operation.call(memory)).to eq([3, 5])
      end
    end

    context 'with [0, 1]' do
      let(:args_modes) { [0, 1] }

      it 'fetches all input in immediate mode' do
        operation = described_class.new(
          operation_type: operation_type,
          args: [3, 4, 5],
          args_modes: args_modes
        )
        expect(operation.call(memory)).to eq([4, 4])
      end
    end

    context 'with [1, 1, 1]' do
      let(:args_modes) { [1, 1, 1] }

      it 'ignores extra argument mode' do
        operation = described_class.new(
          operation_type: operation_type,
          args: [3, 4, 5],
          args_modes: args_modes
        )
        expect(operation.call(memory)).to eq([3, 4])
      end
    end
  end
end
