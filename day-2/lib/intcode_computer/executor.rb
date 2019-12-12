require 'intcode_computer/operations_factory'
require 'intcode_computer/opcode_iterator'

module IntcodeComputer
  class Executor
    def initialize(memory)
      @memory = memory
      @operations_factory = OperationsFactory.new(@memory)
    end

    def execute
      OpcodeIterator.new(@memory).each do |iterator|
        @operations_factory.from_iterator(iterator).execute
      end

      @memory
    end
  end
end
