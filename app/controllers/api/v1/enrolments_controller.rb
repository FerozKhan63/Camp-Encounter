class Api::V1::EnrolmentsController < ApplicationController
  before_action :set_enrolment, only: %i[show update destroy]
  skip_before_action :verify_authenticity_token
  
  def index
    @enrolments = Enrolment.all 
    render json: @enrolments
  end 

  def show
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
    if @enrolment.update(enrolment_params)
      render json: @enrolment
    else
      render json: @enrolment.errors.full_messages
    end
  end

  def destroy
    @enrolments = Enrolment.all 
    @enrolment.destroy
    render json: @enrolments
  end

  private
  
  def set_enrolment
    @enrolment = Enrolment.find(params[:id])
  end

  def enrolment_params
    params.permit(
    :gender, :age, :camp_options, :tent_sharing, :emergency_contact,
    :medical_history, :blood_group, :cnic, :billing_address, :mailing_address,
    :experience, :progress, :submitted, :insurance, :user_id, :camp_id
    )
  end
end
