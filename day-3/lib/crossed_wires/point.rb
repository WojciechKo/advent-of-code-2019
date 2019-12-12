module CrossedWires
  Point = Struct.new(:x, :y) do
    def <=>(other)
      x_comparison = x <=> other.x
      return x_comparison unless x_comparison.zero?

      y <=> other.y
    end

    def distance(other)
      (x - other.x).abs + (y - other.y).abs
    end
  end
end
