class SecretCode < ApplicationRecord

  NO_OF_CODES = [1, 10, 20, 50, 100]

  has_one :user

  validates_presence_of :code
  validates_uniqueness_of :code

  def self.generate_random_codes no_of_codes
    existing_codes = SecretCode.pluck(:code)
    new_codes = (1..no_of_codes).map{|k| SecureRandom.hex(8)}.uniq
    new_codes = new_codes - existing_codes
    new_codes
  end

  def user_email
    self.user.try(:email)
  end
  
end
