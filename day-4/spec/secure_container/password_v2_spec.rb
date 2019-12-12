require 'secure_container/password_v2'

RSpec.describe SecureContainer::PasswordV2 do
  shared_examples 'valid passwords' do |passwords|
    describe 'valid passwords' do
      passwords.each do |password|
        it password do
          expect(described_class.new(password)).to be_valid
        end
      end
    end
  end

  shared_examples 'invalid passwords' do |passwords|
    describe 'invalid passwords' do
      passwords.each do |password|
        it password do
          expect(described_class.new(password)).to_not be_valid
        end
      end
    end
  end

  include_examples 'valid passwords', [
    '112233',
    '111122'
  ]

  include_examples 'invalid passwords', [
    '123444'
  ]
end
