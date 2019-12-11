require 'crossed_wires/input_parser'
require 'crossed_wires/intersection_finder'
require 'crossed_wires/wire'

module CrossedWires
  def part_1(input)
    wires = input.split("\n")
      .map { InputParser.new.extract_points(_1) }
      .map { Wire.new(_1) }

    IntersectionFinder.new.distance_to_the_closest_by_manhattan(*wires)
  end

  module_function :part_1
end
