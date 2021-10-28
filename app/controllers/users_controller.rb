class UsersController < AdminController
  before_action :set_user, only: %i[ show edit update destroy ]
  
  def index
    # byebug
    if params[:query].present?
      @users = User.global_search(params[:query])
    else
      @users = User.all
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.js
      format.html 
    end 
  end
  
  def create; end

  def show; end

  def edit; end

  def update; end

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

  # def user_params
  #   params.require(:user).permit(:first_name, :email)
  # end
end