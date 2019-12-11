require 'delegate'

module CrossedWires
  WirePart = Struct.new(:begining, :end)
  Point = Struct.new(:x, :y)

  class Wire < SimpleDelegator
    def self.from_input(input)
      new([WirePart.new(Point.new(0,0), Point.new(0,62))])
    end
  end
end
