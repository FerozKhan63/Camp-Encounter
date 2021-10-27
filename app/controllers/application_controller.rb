class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name,:last_name ,:email,:country,:country_code,:phone_number, :password,:terms_of_service)}
        devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name,:last_name, :email, :password,:country,:country_code,:phone_number, :current_password)}
    end

    def after_sign_in_path_for(resource)
        if current_user.admin? 
          users_path
        elsif current_user.superadmin? 
          root_path
        elsif current_user.user? 
          root_path
        end
    end

end
