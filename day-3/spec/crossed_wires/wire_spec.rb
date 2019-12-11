require 'crossed_wires/wire'

RSpec.describe CrossedWires::Wire do
  describe '::from_input' do
    subject(:instance) { described_class.from_input(input) }

    describe '#horizontal_parts' do
      subject(:horizontal_parts) { instance.horizontal_parts }

      describe 'returns sorted parts' do
        context 'case 1' do
          let(:input) { 'U5,R4,D10,L10' }

          it 'return horizontal parts of wire' do
            expect(horizontal_parts).to match_array [
              have_attributes(begining: have_attributes(x: -6, y: -5),
                              end: have_attributes(x: 4, y: -5)),
              have_attributes(begining: have_attributes(x: 0, y: 5),
                              end: have_attributes(x: 4, y: 5))
            ]
          end
        end

        context 'case 2' do
          let(:input) { 'L4,D5,R10,U10' }

          it 'return horizontal parts of wire' do
            expect(horizontal_parts).to match_array [
              have_attributes(begining: have_attributes(x: -4, y: -5),
                              end: have_attributes(x: 6, y: -5)),
              have_attributes(begining: have_attributes(x: -4, y: 0),
                              end: have_attributes(x: 0, y: 0))
            ]
          end
        end
      end
    end

    describe '#vertical_parts' do
      subject(:vertical_parts) { instance.vertical_parts }

      describe 'returns sorted parts' do
        context 'case 1' do
          let(:input) { 'U5,R4,D10,L10' }

          it 'returns vertical parts of wire' do
            expect(vertical_parts).to match_array [
              have_attributes(begining: have_attributes(x: 0, y: 0),
                              end: have_attributes(x: 0, y: 5)),
              have_attributes(begining: have_attributes(x: 4, y: -5),
                              end: have_attributes(x: 4, y: 5))
            ]
          end
        end

        context 'case 2' do
          let(:input) { 'L4,D5,R10,U10' }

          it 'returns vertical parts of wire' do
            expect(vertical_parts).to match_array [
              have_attributes(begining: have_attributes(x: -4, y: -5),
                              end: have_attributes(x: -4, y: 0)),
              have_attributes(begining: have_attributes(x: 6, y: -5),
                              end: have_attributes(x: 6, y: 5))
            ]
          end
        end
      end
    end
    describe '#points' do
      subject(:points) { instance.points }

      context 'with multiple paths' do
        let(:input) { 'U5,R4,D10,L10' }

        it 'creates a correct wire' do
          expect(points).to match_array [
            have_attributes(x: 0, y: 0),
            have_attributes(x: 0, y: 5),
            have_attributes(x: 4, y: 5),
            have_attributes(x: 4, y: -5),
            have_attributes(x: -6, y: -5)
          ]
        end
      end

      context 'with a single path' do
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

      context 'with multiple paths' do
        let(:input) { 'U5,R4,D10,L10' }

        it 'creates a correct wire' do
          expect(points).to match_array [
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

  describe '#intersections' do
    let(:wire_alfa) do
      CrossedWires::Wire.new(
        [
          CrossedWires::Point.new(0, 0),
          CrossedWires::Point.new(0, 30),
          CrossedWires::Point.new(40, 30),
          CrossedWires::Point.new(40, 10),
          CrossedWires::Point.new(20, 10),
          CrossedWires::Point.new(20, 50)
        ]
      )
    end

    let(:wire_bravo) do
      CrossedWires::Wire.new(
        [
          CrossedWires::Point.new(0, 0),
          CrossedWires::Point.new(50, 0),
          CrossedWires::Point.new(50, 40),
          CrossedWires::Point.new(10, 40),
          CrossedWires::Point.new(10, 30)
        ]
      )
    end

    context 'case 1' do
      subject { wire_alfa.intersections(wire_bravo) }

      it 'returns intersection points' do
        is_expected.to contain_exactly(
          CrossedWires::Point.new(20, 40),
          CrossedWires::Point.new(10, 30)
        )
      end
    end

    context 'case 2' do
      subject { wire_bravo.intersections(wire_alfa) }

      it 'returns intersection points' do
        is_expected.to contain_exactly(
          CrossedWires::Point.new(20, 40),
          CrossedWires::Point.new(10, 30)
        )
      end
    end
  end
end
