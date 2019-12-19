require 'forwardable'

module IntcodeComputer
  class Operation
    def initialize(operation_type:, args: [], args_modes: [])
      @operation_type = operation_type
      @args_modes = build_args_modes(args_modes)
      @args = args
    end

    def call(memory)
      input_args = read_input_args(memory)

      @operation_type.operation.call(*input_args).tap do |result|
        output_arg = read_output_arg(memory)
        memory[output_arg] = result if output_arg
      end
    end

    extend Forwardable
    def_delegators :@operation_type, :required_args, :opcode

    attr_reader :args, :args_modes

    def next_index(index)
      index + required_args + 1
    end

    private

    def build_args_modes(args_modes)
      Array.new(@operation_type.input_args_count) do |i|
        args_modes[i] || 0
      end
    end

    def read_input_args(memory)
      input_args_fetchers.map { |fetcher| fetcher.call(memory) }
    end

    def input_args_fetchers
      args_modes.zip(args).map do |mode, arg|
        case mode
        when 0 then position_parameter_fetcher(arg)
        when 1 then immediate_parameter_fetcher(arg)
        else raise "Unknown parameter mode #{mode.inspect}"
        end
      end
    end

    def read_output_arg(memory)
      output_arg_fetcher.call(memory)
    end

    def output_arg_fetcher
      if @operation_type.store_output
        output_arg = args[@operation_type.input_args_count]
        immediate_parameter_fetcher(output_arg)
      else
        null_fetcher
      end
    end

    def position_parameter_fetcher(position)
      ->(memory) { memory[position] }
    end

    def immediate_parameter_fetcher(value)
      ->(_) { value }
    end

    def null_fetcher
      ->(_) {}
    end
  end
end
