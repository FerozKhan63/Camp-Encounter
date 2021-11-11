class Admin::EnrolmentsController < AdminController
  before_action :set_enrolment, only: %i[ show edit update destroy ]
  
  def index
    @pagy, @enrolments = pagy(Enrolment.all, items: 3)
    @enrolment = Enrolment.pluck(:user_id)
    @users = User.find(@enrolment)

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
    params.require(:enrolment).permit(:gender, :age, :camp_options, :tent_sharing, :emergency_contact, :medical_history, :blood_group, :cnic, 
    :billing_address, :mailing_address, :experience, :progress, :submitted, :insurance)
  end
end
