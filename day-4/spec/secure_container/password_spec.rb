require 'secure_container/password'

RSpec.describe SecureContainer::Password do
  shared_examples 'valid passwords' do |passwords|
    describe 'valid passwords' do
      passwords.each do |password|
        it password do
          expect(SecureContainer::Password.new(password)).to be_valid
        end
      end
    end
  end

  shared_examples 'invalid passwords' do |passwords|
    describe 'invalid passwords' do
      passwords.each do |password|
        it password do
          expect(SecureContainer::Password.new(password)).to_not be_valid
        end
      end
    end
  end

  include_examples 'valid passwords', [
    '111123',
    '111111'
  ]

  include_examples 'invalid passwords', [
    '223450',
    '123789'
  ]
end
