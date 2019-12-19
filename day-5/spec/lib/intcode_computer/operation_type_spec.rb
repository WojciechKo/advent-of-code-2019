require 'intcode_computer/operation_type'

RSpec.describe IntcodeComputer::OperationType do
  subject(:operation_type) do
    described_class.new(
      opcode: 1,
      operation: operation,
      store_output: store_output
    )
  end

  describe '#required_args' do
    subject(:required_args) { operation_type.required_args }

    context 'with no args operation' do
      let(:operation) { -> {} }

      context 'without storing the result' do
        let(:store_output) { false }
        it { is_expected.to eq(0) }
      end

      context 'with storing storing the result' do
        let(:store_output) { true }
        it { is_expected.to eq(1) }
      end
    end

    context 'with one arg operation' do
      let(:operation) { ->(a) { a } }

      context 'without storing storing the result' do
        let(:store_output) { false }
        it { is_expected.to eq(1) }
      end

      context 'with storing storing the result' do
        let(:store_output) { true }
        it { is_expected.to eq(2) }
      end
    end

    context 'with one arg operation' do
      let(:operation) { ->(a, b) { a + b } }

      context 'without storing storing the result' do
        let(:store_output) { false }
        it { is_expected.to eq(2) }
      end

      context 'with storing storing the result' do
        let(:store_output) { true }
        it { is_expected.to eq(3) }
      end
    end
  end
end
