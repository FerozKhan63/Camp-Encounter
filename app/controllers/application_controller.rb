class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    protected
    
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :country, :country_code, :phone_number, :password, :password_confirmations, :terms_of_service])
        devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :email, :password, :country, :country_code, :phone_number, :current_password])
    end
end
