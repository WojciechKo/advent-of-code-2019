require 'intcode_computer/operations_factory'

module IntcodeComputer
  class OpcodeIterator
    def initialize(memory)
      @memory = memory
      @index = 0
    end

    include Enumerable

    def each
      loop { yield(next_operation) || return }
    end

    def next_operation
      operations_factory.from_iterator(self).tap do
        move_index
      end
    end

    def opcode
      @memory[@index]
    end

    def args(count)
      (1..count)
        .map { _1 + @index }
        .then { @memory.values_at(*_1) }
    end

    private

    def move_index
      @index += 4
    end

    def operations_factory
      @operations_factory ||= OperationsFactory.new(@memory)
    end
  end
end
