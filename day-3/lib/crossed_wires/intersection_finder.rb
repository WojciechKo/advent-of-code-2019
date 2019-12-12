require 'crossed_wires/point'

module CrossedWires
  class IntersectionFinder
    def all_intersections(first_wire, second_wire)
      intersections = [
        *find_intersections(
          horizontals: first_wire.horizontal_sections,
          verticals: second_wire.vertical_sections
        ),
        *find_intersections(
          horizontals: second_wire.horizontal_sections,
          verticals: first_wire.vertical_sections
        )
      ]

      intersections.reject { _1.x.zero? && _1.y.zero? }
    end

    def distance_to_the_closest_by_manhattan(*wires)
      all_intersections(*wires)
        .map!(&manhattan_distance)
        .min
    end

    def distance_to_the_closest_by_steps(*wires)
      all_intersections(*wires)
        .map!(&step_distance(*wires))
        .min
    end

    private

    def manhattan_distance
      ->(point) { point.x.abs + point.y.abs }
    end

    def step_distance(*wires)
      lambda do |point|
        wires.map { |wire| wire.steps_to(point) }
          .sum
      end
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
      ->(vertical) { horizontal.x_range.cover?(vertical.begining.x) }
    end

    def covers_y?(horizontal)
      ->(vertical) { vertical.y_range.cover?(horizontal.begining.y) }
    end
  end
end
