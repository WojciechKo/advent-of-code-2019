require 'intcode_computer/operation'
require 'intcode_computer/operation_type'

module IntcodeComputer
  class OpcodeIterator
    include Enumerable

    def initialize(intcode)
      @intcode = intcode
      @index = 0
    end

    def each
      return enum_for(:each) unless block_given?

      loop do
        operation = next_operation
        break unless operation

        yield(operation)

        @index = operation.next_index(@index)
      end
    end

    private

    def next_operation
      return unless @index < @intcode.size

      operation_type = operation_type_from(current_opcode)
      args = current_args.take(operation_type.required_args).to_a

      Operation.new(
        operation_type: operation_type,
        args_modes: args_modes,
        args: args
      )
    end

    def operation_type_from(opcode)
      operation_type = SUPPORTED_OPERATIONS.find { _1.opcode == opcode }
      raise "Unexpected opcode: #{opcode.inspect}" unless operation_type

      operation_type
    end

    SUPPORTED_OPERATIONS = [
      OperationType::Addition,
      OperationType::Multiplication,
      OperationType::Read,
      OperationType::Print,
      OperationType::LessThan,
      OperationType::Equals,
      OperationType::Terminate
    ].freeze

    def current_opcode
      (instruction % 100)
    end

    def args_modes
      instruction.to_s[0...-2].split('').reverse!.map!(&:to_i)
    end

    def instruction
      @intcode[@index]
    end

    def current_args
      (1..)
        .lazy
        .map { @intcode[@index + _1] }
    end

    def move_index(offset)
      @index += offset
    end
  end
end
