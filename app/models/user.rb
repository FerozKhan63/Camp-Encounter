class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  enum role: [:user, :superadmin, :admin]
  
  after_initialize :set_default_role, :if => :new_record?
  def set_default_role
    self.role ||= :user
  end

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,:confirmable
  
  
  validates :email, uniqueness: true       
  validates :first_name,presence: true ,length: { minimum: 2 },format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :country, presence: true, length: {minimum: 2}, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :phone_number,uniqueness: true, format: {with: /\(?[0-9]{3}\)?-[0-9]{3}-[0-9]{4}/, message: "Phone numbers must be in xxx-xxx-xxxx format."}
  validates :password, format: {with: /(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}/,message: " must contain at least (1) special characters. Password must contain at least (1) uppercase letter. Password must be at least 7 characters long."}
  validates :country_code, presence: true, length: {minimum: 2}
  validates :terms_of_service ,acceptance: {message: 'If you do not agree to the terms and service please contact global@campencounter.com'}

end
