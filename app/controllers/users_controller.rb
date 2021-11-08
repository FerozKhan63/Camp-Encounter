class UsersController < Devise::RegistrationsController
  before_action :set_user, only: %i[ select_camp enroll show update destroy ]

  def show
    respond_to do |format|
      format.js
      format.html 
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :country_code, :phone_number, :country, :country_select, 
      :role, :password, :password_confirmation, :profile_picture, camp_ids: [])
  end
end
