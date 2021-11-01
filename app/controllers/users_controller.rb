class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  def show
    @user = User.find(params[:id])
   
    respond_to do |format|
      format.js
      format.html 
    end
  end

  def edit

  end

  def update
    if @user.update(user_params)
      redirect_to users_path
     else
      render 'edit'
     end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.js
    end  
  end
  
  private

  def set_user
    @user = User.find(params[:id])
  end

 

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :country_code, :phone_number, :country, :country_select, :role, :password, :password_confirmation)
  end
end
