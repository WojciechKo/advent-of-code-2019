require 'intcode_computer/opcode_iterator'

RSpec.describe IntcodeComputer::OpcodeIterator do
  subject(:iterator) { described_class.new(intcode) }
  subject(:enumerator) { iterator.each }

  describe 'enumeration' do
    let(:intcode) { [1, 0, 0, 0] }

    it 'raises an exception when want to exceed enumerator' do
      expect(enumerator.next).to have_attributes(
        opcode: 1,
        args: match_array([0, 0, 0]),
        args_modes: match_array([0, 0])
      )

      expect { enumerator.next }.to raise_error(StopIteration)
    end
  end

  describe 'reading args modes' do
    context 'without provided args modes' do
      let(:intcode) { [1, 0, 0, 0] }

      it 'Uses 0 as default' do
        expect(enumerator.next).to have_attributes(
          opcode: 1,
          args: match_array([0, 0, 0]),
          args_modes: match_array([0, 0])
        )
      end
    end

    context 'with arg mode for first argument' do
      let(:intcode) { [101, 0, 0, 0] }

      it 'sets that mode for the first argument' do
        expect(enumerator.next).to have_attributes(
          opcode: 1,
          args: match_array([0, 0, 0]),
          args_modes: match_array([1, 0])
        )
      end
    end

    context 'with arg mode for two arguments' do
      context 'with 11' do
        let(:intcode) { [1101, 0, 0, 0] }

        it 'sets mode for the both of the arguments' do
          expect(enumerator.next).to have_attributes(
            opcode: 1,
            args: match_array([0, 0, 0]),
            args_modes: match_array([1, 1])
          )
        end
      end

      context 'with 10' do
        let(:intcode) { [1001, 0, 0, 0] }

        it 'sets mode for the both of the arguments' do
          expect(enumerator.next).to have_attributes(
            opcode: 1,
            args: match_array([0, 0, 0]),
            args_modes: match_array([0, 1])
          )
        end
      end
    end

    context 'with extra arg mode' do
      let(:intcode) { [10101, 0, 0, 0] }

      it 'its being ignored' do
        expect(enumerator.next).to have_attributes(
          opcode: 1,
          args: match_array([0, 0, 0]),
          args_modes: match_array([1, 0])
        )
      end
    end
  end

  describe 'pasing multiple operations' do
    subject(:operations) { iterator.to_a }

    context 'case with each of the supported operations' do
      let(:intcode) do
        [
          1, 2, 3, 4,
          2, 3, 4, 5,
          3, 4,
          4, 5,
          99
        ]
      end

      it do
        is_expected.to include(
          have_attributes(
            opcode: 1,
            args: match_array([2, 3, 4]),
            args_modes: match_array([0, 0])
          )
        )
      end

      it do
        is_expected.to include(
          have_attributes(
            opcode: 2,
            args: match_array([3, 4, 5]),
            args_modes: match_array([0, 0])
          )
        )
      end

      it do
        is_expected.to include(
          have_attributes(
            opcode: 3,
            args: match_array([4]),
            args_modes: match_array([])
          )
        )
      end

      it do
        is_expected.to include(
          have_attributes(
            opcode: 4,
            args: match_array([5]),
            args_modes: match_array([0])
          )
        )
      end

      it do
        is_expected.to include(
          have_attributes(
            opcode: 99,
            args: match_array([]),
            args_modes: match_array([])
          )
        )
      end
    end
  end
end
