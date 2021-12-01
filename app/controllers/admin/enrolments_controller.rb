class Admin::EnrolmentsController < AdminController
  include PagySearch

  before_action :set_enrolment, only: %i[show edit update destroy]
  before_action :check_progress, only: [:show, :edit]
  helper_method :sort_column, :sort_direction
  
  def index
    @pagy, @enrolments = pagy_sort_filter(params[:query], Enrolment)
  end

  def show; end

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
    @enrolment = Enrolment.find_by(id: params[:id])
    redirect_to admin_enrolments_path unless @enrolment
  end

  def check_progress
    unless @enrolment.completed?
      redirect_to admin_enrolments_path, alert: "Can only view or edit application after 100 percent completion."
    end
  end

  def enrolment_params
    params.require(:enrolment).permit(
      :gender, :age, :camp_options, :tent_sharing, :emergency_contact, 
      :medical_history, :blood_group, :cnic, :billing_address, :mailing_address, 
      :experience, :progress, :submitted, :insurance
    )
  end

   def sort_column
    Enrolment.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end
end
