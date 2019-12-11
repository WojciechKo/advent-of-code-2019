require 'delegate'

module CrossedWires
  Point = Struct.new(:x, :y) do
    def <=>(other)
      x_comparison = x <=> other.x
      return x_comparison unless x_comparison.zero?

      y <=> other.y
    end
  end
  WirePart = Struct.new(:begining, :end)

  class Wire < SimpleDelegator
    def self.from_input(input)
      points = InputParser.new.extract_points(input)
      new(points)
    end

    def points
      __getobj__
    end

    def horizontal_parts
      points.each_cons(2)
        .select { _1.y == _2.y }
        .sort_by { |first, _| first.y }
        .map { WirePart.new(*[_1, _2].sort) }
    end

    class InputParser
      def extract_points(input)
        movements = extract_movements(input)

        starting_point = Point.new(0, 0)
        movements.reduce([starting_point]) do |result, movement|
          next_point = movement.call(result.last)
          result.push(next_point)
        end
      end

      private

      def extract_movements(input)
        input.split(',')
          .map { extract_movement(_1) }
      end

      def extract_movement(input_move)
        direction = input_move[0...1]
        distance = input_move[1..-1].to_i

        movement = case direction
                   when 'U' then to_up
                   when 'D' then to_down
                   when 'R' then to_right
                   when 'L' then to_left
                   else raise "Unknown direction: #{direction.inspect}"
                   end

        movement.curry[distance]
      end

      def to_left
        ->(distance, start) { Point.new(start.x - distance, start.y) }
      end

      def to_right
        ->(distance, start) { Point.new(start.x + distance, start.y) }
      end

      def to_up
        ->(distance, start) { Point.new(start.x, start.y + distance) }
      end

      def to_down
        ->(distance, start) { Point.new(start.x, start.y - distance) }
      end
    end
  end
end
