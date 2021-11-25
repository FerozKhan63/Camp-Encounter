class Admin::UsersController < AdminController
  include PagySearch
  
  before_action :set_user, only: %i[show edit update destroy]
  helper_method :sort_column, :sort_direction

  def index
    (@pagy, @users) = pagy_sort_filter(params[:query], User)
    
    respond_to do |format|
      format.html
      format.csv { send_data ExportToCsvService.new(User).call, filename: "Users-#{Date.today}.csv" }
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
    result = InviteUser.call(user_params: user_params, 
                            model_name: User, 
                            token: :reset_password_token)
    @user = result.user
    
    if result.success?
      UserMailer.send_invite_email(@user, result.raw).deliver
      redirect_to admin_users_path, notice: "An invitation has been sent to the user!"
    else
      flash.now[:error] = result.error
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
    redirect_to admin_users_path if !@user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :country_code, :phone_number, :country, :country_select, 
      :role, :password, :password_confirmation, :profile_picture)
  end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "first_name"
  end
end
