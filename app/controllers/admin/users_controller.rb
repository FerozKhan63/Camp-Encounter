class Admin::UsersController < AdminController
  before_action :set_user, only: %i[show edit update destroy]
  helper_method :sort_column, :sort_direction

  def index
    if params[:query].present?
      @users = User.global_search(params[:query]).order(sort_column + " " + sort_direction)
    else
      @users = User.order(sort_column + " " + sort_direction)
    end
    @pagy, @users = pagy(@users, items: 3)

    respond_to do |format|
      format.html
      format.csv { send_data User.all.to_csv, filename: "Users-#{Date.today}.csv" }
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
    @user.reset_password_sent_at = Time.current

    if @user.save
      UserMailer.send_invite_email(@user,raw).deliver
      redirect_to admin_users_path, notice: "An invitation has been sent to the user!"
    else
      flash.now[:error] = "There are some errors in the provided details. Please resubmit the form with the correct details."
      render :new
    end
  end

  def show   
    respond_to do |format|
      format.js
      format.html 
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path
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
    @user = User.find_by(id: params[:id])
    redirect_to root_path if !@user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :country_code, :phone_number, :country, :country_select, 
      :role, :password, :password_confirmation, :profile_picture)
  end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "first_name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
