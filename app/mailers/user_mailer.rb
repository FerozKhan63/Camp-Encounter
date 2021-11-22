class UserMailer < ApplicationMailer
  def send_invite_email(user,raw) 
    @user = user 
    @token = raw
    mail( to: @user.email, subject: 'Welcome to Encounters!')
  end 
end
