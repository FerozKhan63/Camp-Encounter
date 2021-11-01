class AdminController < ApplicationController
    before_action :authenticate_user!
    # before_action :admin_only
    
    private

    def admin_only
        if current_user.user?
            redirect_to root_path, alert: "You need to be admin"
        end
    end
end
