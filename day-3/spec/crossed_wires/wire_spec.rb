require 'crossed_wires/wire'
require 'crossed_wires/point'

RSpec.describe CrossedWires::Wire do
  subject(:wire) { described_class.new(points) }

  let(:points_alfa) do
    [
      CrossedWires::Point.new(0, 0),
      CrossedWires::Point.new(0, 5),
      CrossedWires::Point.new(4, 5),
      CrossedWires::Point.new(4, -5),
      CrossedWires::Point.new(-6, -5)
    ]
  end

  let(:points_bravo) do
    [
      CrossedWires::Point.new(0, 0),
      CrossedWires::Point.new(-4, 0),
      CrossedWires::Point.new(-4, -5),
      CrossedWires::Point.new(6, -5),
      CrossedWires::Point.new(6, 5)
    ]
  end

  describe '#horizontal_sections' do
    subject(:horizontal_sections) { wire.horizontal_sections }

    context 'case 1' do
      let(:points) { points_alfa }

      it 'returns sorted horizontal parts of wire' do
        expect(horizontal_sections).to match_array [
          have_attributes(begining: have_attributes(x: -6, y: -5),
                          end: have_attributes(x: 4, y: -5)),
          have_attributes(begining: have_attributes(x: 0, y: 5),
                          end: have_attributes(x: 4, y: 5))
        ]
      end
    end

    context 'case 2' do
      let(:points) { points_bravo }

      it 'returns sorted horizontal parts of wire' do
        expect(horizontal_sections).to match_array [
          have_attributes(begining: have_attributes(x: -4, y: -5),
                          end: have_attributes(x: 6, y: -5)),
          have_attributes(begining: have_attributes(x: -4, y: 0),
                          end: have_attributes(x: 0, y: 0))
        ]
      end
    end
  end

  describe '#vertical_sections' do
    subject(:vertical_sections) { wire.vertical_sections }

    context 'case 1' do
      let(:points) { points_alfa }

      it 'returns sorted vertical parts of wire' do
        expect(vertical_sections).to match_array [
          have_attributes(begining: have_attributes(x: 0, y: 0),
                          end: have_attributes(x: 0, y: 5)),
          have_attributes(begining: have_attributes(x: 4, y: -5),
                          end: have_attributes(x: 4, y: 5))
        ]
      end
    end

    context 'case 2' do
      let(:points) { points_bravo }

      it 'returns vertical parts of wire' do
        expect(vertical_sections).to match_array [
          have_attributes(begining: have_attributes(x: -4, y: -5),
                          end: have_attributes(x: -4, y: 0)),
          have_attributes(begining: have_attributes(x: 6, y: -5),
                          end: have_attributes(x: 6, y: 5))
        ]
      end
    end
  end
end
