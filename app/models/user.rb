class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  
  
  validates :email, uniqueness: true       
  # validates :first_name,:last_name, presence: true ,length: { minimum: 2 },format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :country, presence: true, length: {minimum: 2}, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :phone_number, format: {with: /\(?[0-9]{3}\)?-[0-9]{3}-[0-9]{4}/, message: "Phone numbers must be in xxx-xxx-xxxx format."}
  validates :password, format: {with: /(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}/,message: "Password must contain atleast one uppercase,lowercase and sepacial charecter"}
  validates :country_code, presence: true, length: {minimum: 2}
  validates :terms_of_service ,acceptance: true

end
