class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,:confirmable
  
  PASSWORD_REGEX = /(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}/
  PHONE_REGEX = /\(?[0-9]{3}\)?-[0-9]{3}-[0-9]{4}/
  ALPHABETS_ONLY = /\A[a-zA-Z]+\z/
  
  validates :first_name, :country, presence: true , length: { minimum: 2 }, format: { with: ALPHABETS_ONLY, message: "only allows letters" }
  validates :phone_number, format: { with: PHONE_REGEX, message: "Phone numbers must be in xxx-xxx-xxxx format." }
  validates :password, format: { with: PASSWORD_REGEX, message: "must contain at least (1) special characters. Password must contain at least (1) uppercase letter. Password must be at least 7 characters long." }
  validates :country_code, presence: true, length: { minimum: 2 }
  validates :terms_of_service , acceptance: { message: 'If you do not agree to the terms and service please contact xyz@campencounter.com' }
end
