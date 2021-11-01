class User < ApplicationRecord
  
  PASSWORD_REGEX = /(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}/

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,:confirmable

  validates :first_name, :country, presence: true , length: { minimum: 2 }, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :phone_number, format: { with: /\(?[0-9]{3}\)?-[0-9]{3}-[0-9]{4}/, message: "Phone numbers must be in xxx-xxx-xxxx format." }
  validates :password, format: { with: PASSWORD_REGEX, message: "must contain at least (1) special characters. Password must contain at least (1) uppercase letter. Password must be at least 7 characters long." }
  validates :country_code, presence: true, length: { minimum: 2 }
  validates :terms_of_service , acceptance: { message: 'If you do not agree to the terms and service please contact xyz@campencounter.com' }
end
