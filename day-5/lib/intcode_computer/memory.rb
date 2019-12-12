require 'delegate'

module IntcodeComputer
  class Memory < SimpleDelegator
    def self.from_string(string)
      new(string.split(',').map(&:to_i))
    end

    def initialize(intcode)
      super(intcode)
    end
  end
end
