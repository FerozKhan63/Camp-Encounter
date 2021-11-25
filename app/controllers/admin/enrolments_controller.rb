class Admin::EnrolmentsController < AdminController
  before_action :set_enrolment, only: %i[show edit update destroy]
  before_action :check_progress, only: [:show, :edit]
  
  def index
    @pagy, @enrolments = pagy(Enrolment.all, items: 3)
  end

  def show
    @user = User.find_by(id: @enrolment.user_id) 
  end

  def edit; end

  def update
    if @enrolment.update(enrolment_params)
      redirect_to admin_enrolments_path
    else
      render 'edit'
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

  def check_progress
    if @enrolment.progress != 100
      redirect_to admin_enrolments_path, alert: "Can only view or edit application after 100 percent completion."
    end
  end

  def enrolment_params
    params.require(:enrolment).permit(:gender, :age, :camp_options, :tent_sharing, :emergency_contact, :medical_history, :blood_group, :cnic, 
    :billing_address, :mailing_address, :experience, :progress, :submitted, :insurance)
  end
end
