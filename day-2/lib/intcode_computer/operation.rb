module IntcodeComputer
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
