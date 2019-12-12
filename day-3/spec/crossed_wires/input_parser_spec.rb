require 'crossed_wires/input_parser'

RSpec.describe CrossedWires::InputParser do
  subject(:parser) { described_class.new }

  describe '#extract_points' do
    subject(:points) { parser.extract_points(input) }

    context 'with a single wire part' do
      context 'upwards' do
        let(:input) { 'U62' }

        it 'creates a correct wire' do
          expect(points).to match_array [
            have_attributes(x: 0, y: 0),
            have_attributes(x: 0, y: 62)
          ]
        end
      end

      context 'downwards' do
        let(:input) { 'D20' }

        it 'creates a correct wire' do
          expect(points).to match_array [
            have_attributes(x: 0, y: 0),
            have_attributes(x: 0, y: -20)
          ]
        end
      end

      context 'rightwards' do
        let(:input) { 'R5' }

        it 'creates a correct wire' do
          expect(points).to match_array [
            have_attributes(x: 0, y: 0),
            have_attributes(x: 5, y: 0)
          ]
        end
      end

      context 'leftwards' do
        let(:input) { 'L1' }

        it 'creates a correct wire' do
          expect(points).to match_array [
            have_attributes(x: 0, y: 0),
            have_attributes(x: -1, y: 0)
          ]
        end
      end
    end

    context 'with multiple wire parts' do
      context 'case 1' do
        let(:input) { 'U5,R4,D10,L10' }

        it 'returns correct points' do
          expect(points).to match_array [
            have_attributes(x: 0, y: 0),
            have_attributes(x: 0, y: 5),
            have_attributes(x: 4, y: 5),
            have_attributes(x: 4, y: -5),
            have_attributes(x: -6, y: -5)
          ]
        end
      end

      context 'case 2' do
        let(:input) { 'L4,D5,R10,U10' }

        it 'returns correct points' do
          expect(points).to match_array [
            have_attributes(x: 0, y: 0),
            have_attributes(x: -4, y: 0),
            have_attributes(x: -4, y: -5),
            have_attributes(x: 6, y: -5),
            have_attributes(x: 6, y: 5)
          ]
        end
      end
    end
  end
end
