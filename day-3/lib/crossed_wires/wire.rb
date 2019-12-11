require 'delegate'

module CrossedWires
  Point = Struct.new(:x, :y)

  class Wire < SimpleDelegator
    def self.from_input(input)
      starting_point = Point.new(0, 0)

      wire = input.split(',').reduce([starting_point]) do |result, path|
        direction = path[0...1]
        length = path[1..-1].to_i

        last_point = result.last

        next_point = case direction
                     when 'U' then Point.new(last_point.x, last_point.y + length)
                     when 'D' then Point.new(last_point.x, last_point.y - length)
                     when 'R' then Point.new(last_point.x + length, last_point.y)
                     when 'L' then Point.new(last_point.x - length, last_point.y)
                     else raise "Unknown direction: #{direction.inspect}"
                     end


        result.push(next_point)
      end

      new(wire)
    end
  end
end
