require 'intcode_computer/operation'

module IntcodeComputer
  class OperationsFactory
    def initialize(memory)
      @memory = memory
    end

    def from_iterator(iterator)
      case iterator.opcode
      when 1 then add(iterator)
      when 2 then multi(iterator)
      when 99 then terminate
      else raise "Unexpected opcode: #{iterator.opcode.inspect}"
      end
    end

    def add(iterator)
      Operation.new(
        operation: ->(a, b) { a + b },
        strategy: execute_and_store,
        args: iterator.args(3)
      )
    end

    def multi(iterator)
      Operation.new(
        operation: ->(a, b) { a * b },
        strategy: execute_and_store,
        args: iterator.args(3)
      )
    end

    def terminate
      Operation.new(
        operation: -> {},
        strategy: just_execute
      )
    end

    def execute_and_store(_args_count = 0)
      lambda do |operation, args|
        *input_indices, output_index = args

        result = @memory
          .values_at(*input_indices)
          .then { operation.call(*_1) }

        @memory[output_index] = result
      end
    end

    def just_execute(_args_count = 0)
      lambda do |operation, _|
        operation.call
      end
    end
  end
end
