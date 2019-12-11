require 'crossed_wires/wire'

RSpec.describe CrossedWires::Wire do
  describe '::from_input' do
    subject(:wire) { described_class.from_input(input) }

    context 'with a single path' do
      context 'upwards' do
        let(:input) { 'U62' }

        it 'creates a correct wire' do
          expect(wire).to match_array [
            have_attributes(x: 0, y: 0),
            have_attributes(x: 0, y: 62)
          ]
        end
      end

      context 'downwards' do
        let(:input) { 'D20' }

        it 'creates a correct wire' do
          expect(wire).to match_array [
            have_attributes(x: 0, y: 0),
            have_attributes(x: 0, y: -20)
          ]
        end
      end

      context 'rightwards' do
        let(:input) { 'R5' }

        it 'creates a correct wire' do
          expect(wire).to match_array [
            have_attributes(x: 0, y: 0),
            have_attributes(x: 5, y: 0)
          ]
        end
      end

      context 'leftwards' do
        let(:input) { 'L1' }

        it 'creates a correct wire' do
          expect(wire).to match_array [
            have_attributes(x: 0, y: 0),
            have_attributes(x: -1, y: 0)
          ]
        end
      end
    end

    context 'with multiple paths' do
      let(:input) { 'U5,R4,D10,L10' }

      it 'creates a correct wire' do
        expect(wire).to match_array [
          have_attributes(x: 0, y: 0),
          have_attributes(x: 0, y: 5),
          have_attributes(x: 4, y: 5),
          have_attributes(x: 4, y: -5),
          have_attributes(x: -6, y: -5)
        ]
      end
    end
  end
end
