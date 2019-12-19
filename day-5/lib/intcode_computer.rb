require 'intcode_computer/executor'

module IntcodeComputer
  def self.part_1(input)
    intcode = parse_intcode(input)
    Executor.new(intcode).execute
  end

  def part_2; end

  def self.parse_intcode(string)
    string.split(',').map(&:to_i)
  end

  # module_function :part_1, :part_2
end
