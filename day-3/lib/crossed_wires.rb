require 'crossed_wires/input_parser'
require 'crossed_wires/intersection_finder'
require 'crossed_wires/wire'

module CrossedWires
  def part_1(input)
    wires = wires_from_input(input)
    IntersectionFinder.new.distance_to_the_closest_by_manhattan(*wires)
  end

  def part_2(input)
    wires = wires_from_input(input)
    IntersectionFinder.new.distance_to_the_closest_by_steps(*wires)
  end

  module_function :part_1, :part_2

  def self.wires_from_input(input)
    input.split("\n")
      .map { InputParser.new.extract_points(_1) }
      .map { Wire.new(_1) }
  end
end
