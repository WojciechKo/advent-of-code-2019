module CrossedWires
  Point = Struct.new(:x, :y) do
    def <=>(other)
      x_comparison = x <=> other.x
      return x_comparison unless x_comparison.zero?

      y <=> other.y
    end
  end
end
