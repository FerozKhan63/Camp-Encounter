require 'csv'

class User < ApplicationRecord
  include PgSearch::Model

  attr_accessor :skip_password_validation

  pg_search_scope :global_search, against: [:first_name, :last_name, :email, :id], using: { tsearch: { prefix: true } }

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable
  
  PASSWORD_REGEX = /(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}/
  PHONE_REGEX = /\(?[0-9]{3}\)?-[0-9]{3}-[0-9]{4}/
  ALPHABETS_ONLY = /\A[a-zA-Z]+\z/
  ADMIN = :admin
  USER = :user
  SUPER_ADMIN = :superadmin
  ROLES = [USER, SUPER_ADMIN, ADMIN]
  
  enum role: ROLES, _default: :user
    
  validates :first_name, :country, presence: true , length: { minimum: 2 }, format: { with: ALPHABETS_ONLY, message: "only allows letters" }
  validates :phone_number, uniqueness: true, format: { with: PHONE_REGEX , message: " must be in xxx-xxx-xxxx format." }
  validates :password, format: { with: PASSWORD_REGEX, message: "must contain at least (1) special characters. Password must contain at least (1) uppercase letter. Password must be at least 7 characters long." }
  validates :country_code, presence: true, length: { minimum: 2 }
  validates :terms_of_service , acceptance: { message: 'If you do not agree to the terms and service please contact global@campencounter.com' }
  
  private

  def self.to_csv
    attributes = %w{id name email country country_code phone_number role}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end

  def password_required?
    return false if skip_password_validation

    super
  end

  def name
    "#{first_name} #{last_name}"
  end
end
