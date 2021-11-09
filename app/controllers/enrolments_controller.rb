class EnrolmentsController < ApplicationController
  include Wicked::Wizard

  after_action :progress_bar, only: [:update]
  before_action :set_enrolment

  steps :personal_info, :camp_options, :tent_sharing, :emergency_contact, :medical_history , :blood_group, :insurance, 
  :cnic, :address, :experience

  def show
    render_wizard
  end

  def update
    # @enrolment = Enrolment.find(params[:enrolment_id]) 
    @enrolment.attributes = enrolment_params
    render_wizard @enrolment
  end

  private

  def set_enrolment
    @enrolment = Enrolment.find_by(user_id: current_user.id)
  end

  def enrolment_params
   params.require(:enrolment).permit(:gender, :age, :camp_options, :tent_shraing, :emergency_contact, :medical_history, :blood_group, :cnic, 
    :billing_address, :mailing_address, :experience)
  end

  def progress_bar
    @enrolment = Enrolment.find(params[:enrolment_id])
    @enrolment.progress += 10
    @enrolment.save
  end

end
