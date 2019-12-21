module IntcodeComputer
  class OperationTypeFactory
    def self.jump_if_true(index_setter)
      OperationType.new(
        opcode: 5,
        operation: ->(test, index) { index_setter.call(index) unless test.zero? },
        store_output: false
      )
    end

    def self.jump_if_false(index_setter)
      OperationType.new(
        opcode: 6,
        operation: ->(test, index) { index_setter.call(index) if test.zero? },
        store_output: false
      )
    end
  end
end
