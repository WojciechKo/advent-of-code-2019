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
      loop { yield(next_operation || return) }
    end

    private

    def next_operation
      return unless @index < @intcode.size

      build_operation.tap do |operation|
        offset = operation.required_args + 1
        move_index(offset)
      end
    end

    def build_operation
      operation_type = operation_type_from(current_opcode)
      args = current_args.take(operation_type.required_args).to_a

      Operation.new(
        operation_type: operation_type,
        args_modes: args_modes,
        args: args
      )
    end

    def operation_type_from(opcode)
      case opcode
      when 1 then OperationType::Addition
      when 2 then OperationType::Multiplication
      when 3 then OperationType::Read
      when 4 then OperationType::Print
      when 99 then OperationType::Terminate
      else raise "Unexpected opcode: #{opcode.inspect}"
      end
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

    def move_index(offset)
      @index += offset
    end
  end
end
