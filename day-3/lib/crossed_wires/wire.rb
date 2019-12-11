module CrossedWires
  Point = Struct.new(:x, :y) do
    def <=>(other)
      x_comparison = x <=> other.x
      return x_comparison unless x_comparison.zero?

      y <=> other.y
    end

    def distance
      x.abs + y.abs
    end
  end

  WirePart = Struct.new(:begining, :end)

  class Wire
    def self.from_input(input)
      points = InputParser.new.extract_points(input)
      new(points)
    end

    def initialize(points)
      @points = points
    end

    attr_reader :points

    def horizontal_parts
      @horizontal_parts ||= points.each_cons(2)
        .select { _1.y == _2.y }
        .sort_by { |first, _| first.y }
        .map { WirePart.new(*[_1, _2].sort) }
    end

    def vertical_parts
      @vertical_parts ||= points.each_cons(2)
        .select { _1.x == _2.x }
        .sort_by { |first, _| first.x }
        .map { WirePart.new(*[_1, _2].sort) }
    end

    def intersections(wire)
      intersections = [
        *find_intersections(
          horizontals: horizontal_parts,
          verticals: wire.vertical_parts
        ),
        *find_intersections(
          horizontals: wire.horizontal_parts,
          verticals: vertical_parts
        )
      ]

      intersections.reject { _1.x == 0 && _1.y == 0 }
    end

    def find_intersections(horizontals:, verticals:)
      horizontals.flat_map do |part|
        verticals
          .select(&covers_x?(part))
          .select(&covers_y?(part))
          .map { Point.new(_1.begining.x, part.begining.y) }
      end
    end

    def covers_x?(horizontal)
      ->(vertical) { (horizontal.begining.x..horizontal.end.x).cover?(vertical.begining.x) }
    end

    def covers_y?(horizontal)
      ->(vertical) { (vertical.begining.y..vertical.end.y).cover?(horizontal.begining.y) }
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
