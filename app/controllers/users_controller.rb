class UsersController < AdminController
  before_action :set_user, only: %i[ show edit update destroy ]
  
  def index
    @users = User.all
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

  # def article_params
  #   params.require(:article).permit(:title, :body)
  # end
end