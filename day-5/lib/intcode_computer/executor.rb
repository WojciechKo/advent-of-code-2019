require 'intcode_computer/opcode_iterator'

module IntcodeComputer
  class Executor
    def initialize(intcode)
      @intcode = intcode.dup
    end

    def execute
      OpcodeIterator.new(@intcode)
        .take_while { |operation| operation.call(@intcode) }

      @intcode
    end
  end
end
