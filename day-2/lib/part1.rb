require 'delegate'

class Part1
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

      class Operation
        def initialize(strategy:, operation:, args: [])
          @strategy = strategy
          @operation = operation
          @args = args
        end

        def execute
          @strategy.call(@operation, @args)
        end
      end
    end

    class OpcodeIterator
      def initialize(memory)
        @memory = memory
        @index = 0
      end

      include Enumerable

      def each
        loop do
          yield(self) || return
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
    end
  end

  class Memory < SimpleDelegator
    def self.from_string(string)
      new(string.split(',').map(&:to_i))
    end

    def initialize(intcode)
      super(intcode)
    end
  end
end
