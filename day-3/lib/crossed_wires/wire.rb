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

      @vertical_sections.sort_by! { _1.begining.x }
      @horizontal_sections.sort_by! { _1.begining.y }
    end

    class WireSection
      def initialize(first, second)
        @begining, @end = [first, second].sort
      end

      attr_reader :begining, :end

      def vertical?
        begining.x == self.end.x
      end

      def horizontal?
        begining.y == self.end.y
      end
    end
  end
end
