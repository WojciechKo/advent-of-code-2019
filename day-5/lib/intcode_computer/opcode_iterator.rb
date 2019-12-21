require 'intcode_computer/operation'
require 'intcode_computer/operation_type'
require 'intcode_computer/operation_type_factory'

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

        move_index!(operation)
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
      operation_type = supported_operations.find { _1.opcode == opcode }
      raise "Unexpected opcode: #{opcode.inspect}" unless operation_type

      operation_type
    end

    def supported_operations
      @supported_operations ||= [
        OperationType::Addition,
        OperationType::Multiplication,
        OperationType::Read,
        OperationType::Print,
        OperationType::LessThan,
        OperationType::Equals,
        OperationTypeFactory.jump_if_true(index_setter),
        OperationTypeFactory.jump_if_false(index_setter),
        OperationType::Terminate
      ]
    end

    def index_setter
      ->(index) { @jump_to = index }
    end

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

    def move_index(operation)
      @index += operation.required_args + 1
    end
  end
end
