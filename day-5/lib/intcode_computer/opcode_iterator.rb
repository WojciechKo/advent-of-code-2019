module IntcodeComputer
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
