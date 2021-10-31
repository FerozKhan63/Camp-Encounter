module TokenHelper
   def generate_password_token(user)
      user.reset_password_token = User.reset_password_token 
    end
end
