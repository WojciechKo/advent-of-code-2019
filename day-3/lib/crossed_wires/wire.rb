require 'delegate'

module CrossedWires
  WirePart = Struct.new(:begining, :end)
  Point = Struct.new(:x, :y)

  class Wire < SimpleDelegator
    def self.from_input(input)
      direction = input[0...1]
      length = input[1..-1].to_i

      start_point = Point.new(0, 0)

      next_point = case direction
                   when 'U' then Point.new(start_point.x, start_point.y + length)
                   when 'D' then Point.new(start_point.x, start_point.y - length)
                   when 'R' then Point.new(start_point.x + length, start_point.y)
                   when 'L' then Point.new(start_point.x - length, start_point.y)
                   else raise "Unknown direction: #{direction.inspect}"
                   end

      new([WirePart.new(start_point, next_point)])
    end
  end
end
