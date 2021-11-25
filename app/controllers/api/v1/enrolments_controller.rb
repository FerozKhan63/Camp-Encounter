class Api::V1::EnrolmentsController < ApplicationController
  before_action :set_enrolment, only: %i[ show update destroy ]
  skip_before_action :verify_authenticity_token
  
  def index
    @enrolments = Enrolment.all 
    render json: @enrolments
  end 

  def show
    @enrolment = Enrolment.find(params[:id])
    render json: @enrolment
  end 

  def create
    @enrolment = Enrolment.new(enrolment_params)
    @camp = Camp.new
    if @enrolment.save
      render json: @enrolment
    else
      render json: @enrolment.errors.full_messages
    end
  end

  def update
    @enrolment = Enrolment.update(enrolment_params)
    render json: @enrolment
  end

  def destroy
    @enrolments = Enrolment.all 
    @enrolment = Enrolment.find(params[:id])
    @enrolment.destroy
    render json: @enrolments
  end

  private
  
  def set_enrolment
    @enrolment = Enrolment.find session[enrolment_id]
  end

  def enrolment_params
    params.require(:enrolment).permit(
    :gender, :age, :camp_options, :tent_sharing, :emergency_contact,
    :medical_history, :blood_group, :cnic, :billing_address, :mailing_address,
    :experience, :progress, :submitted, :insurance
    )
  end
end
