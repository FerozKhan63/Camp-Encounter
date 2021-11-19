class ApplicationController < ActionController::Base
  include Pagy::Backend
  
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name , :email, :country, :country_code, :phone_number, :password, :terms_of_service])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :email, :password, :country, :country_code, :phone_number, :current_password])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:first_name, :last_name, :phone_number, :country_code])
  end

  def after_sign_in_path_for(resource)
    if current_user.admin? 
      users_path
    else
      root_path
    end
  end
end
