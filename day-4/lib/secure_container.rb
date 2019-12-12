require 'secure_container/password_v1'
require 'secure_container/password_v2'

module SecureContainer
  def part_1(input)
    min, max = input.split('-').map(&:to_i)
    (min..max).select { PasswordV1.new(_1.to_s).valid? }.count
  end

  def part_2(input)
    min, max = input.split('-').map(&:to_i)
    (min..max).select { PasswordV2.new(_1.to_s).valid? }.count
  end

  module_function :part_1, :part_2
end
