class UserMailer < ActionMailer::Base
  default from: "feroz@campencounter.com"

  def send_invite_email(user) 
        @user = user 
        @token = user.reset_password_token
        mail( to: @user.email, subject: 'Welcome to Encounters!')
    end 
 end
