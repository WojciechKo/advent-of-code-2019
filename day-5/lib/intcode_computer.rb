require 'intcode_computer/memory'
require 'intcode_computer/executor'

module IntcodeComputer
  def part_1(input, noun: nil, verb: nil)
    memory = Memory.from_string(input)
    memory[1] = noun if noun
    memory[2] = verb if verb

    Executor.new(memory).execute.first
  end

  def part_2(input, output:)
    (0..99).each do |noun|
      (0..99).each do |verb|
        result = part_1(input, noun: noun, verb: verb)

        return 100 * noun + verb if result == output
      end
    end
  end

  module_function :part_1, :part_2
end
