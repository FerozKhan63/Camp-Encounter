class Admin::EnrolmentsController < AdminController
  before_action :set_enrolment, only: %i[ show edit update destroy ]
  # before_action :set_user, only: %i[ index show edit update destroy ]
  
  def index
    @pagy, @enrolments = pagy(Enrolment.all, items: 3)
    # @enrolment = Enrolment.find(params[:id])
    # @user = User.find_by(id: @enrolment.user_id) 
    respond_to do |format|
      format.html
      format.csv { send_data Enrolment.all.to_csv, filename: "enrolments-#{Date.today}.csv" }
    end
  end

  def show
    @user = User.find_by(id: @enrolment.user_id) 
  end

  def edit
  end

  def update
    if @enrolment.update(enrolment_params)
      redirect_to admin_enrolments_path
    end
  end

  def destroy
    @enrolment.destroy

    respond_to do |format|
      format.js
    end  
  end

  private
  
  def set_enrolment
    @enrolment = Enrolment.find(params[:id])
  end

  def enrolment_params
    params.require(:enrolment).permit(:name, :start_date, :end_date, :registration_date, :status, location_ids: [])
  end
end
