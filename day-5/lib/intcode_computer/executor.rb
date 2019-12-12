require 'intcode_computer/opcode_iterator'

module IntcodeComputer
  class Executor
    def initialize(memory)
      @memory = memory
    end

    def execute
      OpcodeIterator.new(@memory).each(&:execute)
      @memory
    end
  end
end
