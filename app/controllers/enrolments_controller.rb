class EnrolmentsController < ApplicationController
  include Wicked::Wizard

  before_action :set_enrolment
  after_action :progress_bar, only: [:update]
  before_action :check_progress, only: [:update]

  steps :personal_info, :camp_options, :tent_sharing, :emergency_contact, :medical_history , :blood_group, :insurance, 
  :cnic, :address, :experience, :view_application, :dashboard

  def show
    render_wizard
  end

  def update
    @enrolment.update(enrolment_params)
    case step
      when :experience
        @enrolment.update(enrolment_params)
        jump_to(:dashboard)
     end
    render_wizard @enrolment
  end 

  private

  def progress_bar
    if wizard_steps.any? && wizard_steps.index(step).present?
      @enrolment.progress = ((wizard_steps.index(step) + 2).to_d / (wizard_steps.count.to_d - 1)) * 100 
      @enrolment.save
    end
  end

  def set_enrolment
    @enrolment = Enrolment.find session[:enrolment_id]
  end

  def check_progress
    if @enrolment.progress == 100
      redirect_to wizard_path(:dashboard), alert: "You have already submitted this application"
    end
  end

  def enrolment_params
   params.require(:enrolment).permit(:gender, :age, :camp_options, :tent_sharing, :emergency_contact, :medical_history, :blood_group, :cnic, 
    :billing_address, :mailing_address, :experience, :progress, :submitted, :insurance)
  end

end
