class UsersController < Devise::RegistrationsController
  before_action :set_user, only: %i[show]

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
end
