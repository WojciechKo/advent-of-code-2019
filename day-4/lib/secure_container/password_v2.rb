module SecureContainer
  class PasswordV2
    def initialize(password)
      @password = password.split('')
    end

    def valid?
      increasing? && exactly_two_adjacent_digits_the_same?
    end

    private

    def exactly_two_adjacent_digits_the_same?
      @password.tally.values.any?(2)
    end

    def increasing?
      @password.sort == @password
    end
  end
end
