require 'crossed_wires/wire'

module CrossedWires
  class Part1
    def call(input)
      first_wire, second_wire = input.split("\n")
        .map { Wire.from_input(_1) }

      first_wire.intersections(second_wire)
        .min_by(&:distance)
        .distance
    end
  end
end
