require 'secure_container/password'

module SecureContainer
  def part_1(input)
    min, max = input.split('-').map(&:to_i)
    (min..max).select { Password.new(_1.to_s).valid? }.count
  end

  module_function :part_1
end
