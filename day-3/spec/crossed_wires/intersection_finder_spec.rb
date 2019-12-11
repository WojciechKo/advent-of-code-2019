require 'crossed_wires/intersection_finder'
require 'crossed_wires/wire'
require 'crossed_wires/point'

RSpec.describe CrossedWires::IntersectionFinder do
  subject(:finder) { described_class.new }

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

  describe '#all_intersections' do
    subject(:all_intersections) { finder.all_intersections(*wires) }

    context 'first alfa then bravo' do
      let(:wires) { [wire_alfa, wire_bravo] }

      it 'returns intersection points' do
        is_expected.to contain_exactly(
          CrossedWires::Point.new(20, 40),
          CrossedWires::Point.new(10, 30)
        )
      end
    end

    context 'first bravo then alfa' do
      let(:wires) { [wire_bravo, wire_alfa] }

      it 'returns intersection points' do
        expect(all_intersections).to contain_exactly(
          CrossedWires::Point.new(20, 40),
          CrossedWires::Point.new(10, 30)
        )
      end
    end
  end

  describe '#distance_to_the_closest_by_manhattan' do
    subject(:distance_to_the_closest_by_manhattan) { finder.distance_to_the_closest_by_manhattan(*wires) }

    context 'first alfa then bravo' do
      let(:wires) { [wire_alfa, wire_bravo] }

      it 'returns distance to the intersection' do
        expect(distance_to_the_closest_by_manhattan).to eq(40)
      end
    end

    context 'first bravo then alfa' do
      let(:wires) { [wire_bravo, wire_alfa] }

      it 'returns distance to the intersection' do
        expect(distance_to_the_closest_by_manhattan).to eq(40)
      end
    end
  end
end
