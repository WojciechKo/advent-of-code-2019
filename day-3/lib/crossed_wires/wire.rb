module CrossedWires
  class Wire
    def initialize(points)
      @points = points
      initialize_sections!
    end

    attr_reader :points, :horizontal_sections, :vertical_sections

    private

    def initialize_sections!
      @horizontal_sections = []
      @vertical_sections = []

      @points.each_cons(2)
        .map { WireSection.new(_1, _2) }
        .each do |wire_section|
        if wire_section.vertical?
          @vertical_sections << wire_section
        elsif wire_section.horizontal?
          @horizontal_sections << wire_section
        else
          raise "Part is not vertical nor horizontal #{wire_section}"
        end
      end
    end

    class WireSection
      def initialize(begining, ending)
        @begining = begining
        @ending = ending
      end

      attr_reader :begining, :ending

      def vertical?
        begining.x == ending.x
      end

      def horizontal?
        begining.y == ending.y
      end

      def cover?(point)
        x_range.cover?(point.x) && y_range.cover?(point.y)
      end

      def length
        (begining.x - ending.x).abs +
          (begining.y - ending.y).abs
      end

      def x_range
        Range.new(*[begining.x, ending.x].sort)
      end

      def y_range
        Range.new(*[begining.y, ending.y].sort)
      end
    end
  end
end
