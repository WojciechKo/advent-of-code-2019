module IntcodeComputer
  class OperationType
    def initialize(opcode:, operation:, store_output:)
      @opcode = opcode
      @operation = operation
      @store_output = store_output
    end

    def required_args
      args_count = input_args_count
      args_count += 1 if store_output

      args_count
    end

    def input_args_count
      operation.arity
    end

    attr_reader :opcode, :operation, :store_output

    Addition = OperationType.new(
      opcode: 1,
      operation: ->(a, b) { a + b },
      store_output: true
    )

    Multiplication = OperationType.new(
      opcode: 2,
      operation: ->(a, b) { a * b },
      store_output: true
    )

    Read = OperationType.new(
      opcode: 3,
      operation: -> { $stdin.gets.chomp.to_i },
      store_output: true
    )

    Print = OperationType.new(
      opcode: 4,
      operation: ->(value) { puts value; true },
      store_output: false
    )

    LessThan = OperationType.new(
      opcode: 7,
      operation: ->(a, b) { a < b ? 1 : 0 },
      store_output: true
    )

    Equals = OperationType.new(
      opcode: 8,
      operation: ->(a, b) { a == b ? 1 : 0 },
      store_output: true
    )

    Terminate = OperationType.new(
      opcode: 99,
      operation: -> {},
      store_output: false
    )
  end
end
