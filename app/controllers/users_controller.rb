class UsersController < AdminController
  before_action :set_user, only: %i[ show edit update destroy ]

  def index
    if params[:query].present?
      @pagy, @users = pagy(User.global_search(params[:query]).order(created_at: :asc), items: 3)
    else
      @pagy, @users = pagy(User.order(created_at: :asc), items: 3)
    end
    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.js
      format.html 
    end 
  end
  
  def create
    @user = User.new(user_params)
    @user.skip_password_validation = true
    @user.skip_confirmation!
  
    raw, enc = Devise.token_generator.generate(User, :reset_password_token)
    @user.reset_password_token   = enc
    @user.reset_password_sent_at = Time.now.utc

    if @user.save
      UserMailer.send_invite_email(@user,raw).deliver
      redirect_to users_path
      flash[:success] = "An invitation has been sent to the user!"
    else
      flash.now[:error] = "There are some errors in the provided details. Please resubmit the form with the correct details."
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
   
    respond_to do |format|
      format.js
      format.html 
    end
  end

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

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :country_code, :phone_number, :country, :country_select, :role)
  end
end
