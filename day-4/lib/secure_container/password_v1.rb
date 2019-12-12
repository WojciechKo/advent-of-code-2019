module SecureContainer
  class PasswordV1
    def initialize(password)
      @password = password.split('')
    end

    def valid?
      two_adjacent_digits_the_same? && increasing?
    end

    private

    def two_adjacent_digits_the_same?
      @password.each_cons(2).any? { _1 == _2 }
    end

    def increasing?
      @password.sort == @password
    end
  end
end
