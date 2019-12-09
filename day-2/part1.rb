class Part1
  def initialize(input)
    @memory = input.split(',').map(&:to_i)
    @index = 0
  end

  def call
    loop do
      opcode = read_opcode
      operation = operation_from_opcode(opcode)
      return serialize unless operation

      result = operation.call(args_value[0], args_value[1])

      store_result(result, args_index[2])

      move_index
    end
  end

  def serialize
    @memory.join(',')
  end

  private

  def args_value
    ->(position) { @memory[args_index[position]] }
  end

  def args_index
    ->(offset) { @memory[@index + offset + 1] }
  end

  def store_result(result, index)
    @memory[index] = result
  end

  def read_opcode
    @memory[@index]
  end

  def operation_from_opcode(opcode)
    case opcode
    when 1 then ->(a, b) { a + b }
    when 2 then ->(a, b) { a * b }
    when 99 then nil
    else raise "Unexpected opcode: #{opcode.inspect}"
    end
  end

  def move_index
    @index = @index + 4
  end
end
