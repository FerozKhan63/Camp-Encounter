class EnrolmentsController < ApplicationController
  include Wicked::Wizard

  before_action :set_enrolment
  # before_action :check_completion_status
  before_action :progress_bar, only: [:show, :edit]

  steps :personal_info, :camp_options, :tent_sharing, :emergency_contact, :medical_history , :blood_group, :insurance, 
  :cnic, :address, :experience

  def show
    render_wizard
  end

  def update
    case step
      when :personal_info
        @enrolment.update(enrolment_params)
      when :camp_options
        @enrolment.update(enrolment_params)
      when :tent_shraing
        @enrolment.update(enrolment_params)
      when :emergency_contact
        @enrolment.update(enrolment_params)
      when :medical_history
        @enrolment.update(enrolment_params)
      when :blood_group
        @enrolment.update(enrolment_params)
      when :insurance
        @enrolment.update(enrolment_params)
      when :cnic
        @enrolment.update(enrolment_params)
      when :address
        @enrolment.update(enrolment_params)
      when :experience
        @enrolment.update(enrolment_params)
     end
    render_wizard @enrolment
  end 

  private

  def progress_bar
    if wizard_steps.any? && wizard_steps.index(step).present?
      @enrolment.progress = ((wizard_steps.index(step) + 1).to_d / wizard_steps.count.to_d) * 100 
      @enrolment.save
    end
  end

  def set_enrolment
    @enrolment = Enrolment.find session[:enrolment_id]
  end

  def enrolment_params
   params.require(:enrolment).permit(:gender, :age, :camp_options, :tent_sharing, :emergency_contact, :medical_history, :blood_group, :cnic, 
    :billing_address, :mailing_address, :experience, :progress, :submitted, :insurance)
  end

  # def check_completion_status
  #   if params[:id]="wicked_finished" && @enrolment.progress >= 90
  #     render 'confirmation_model'
  #   end
  # end

end
