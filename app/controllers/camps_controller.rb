class CampsController < ApplicationController
  before_action :set_camp, only: %i[show edit update destroy start_enrolment]
  before_action :authenticate_user!
  before_action :check_date, only: [:start_enrolment]
  before_action :check_enrolment, only: [:show]
  
  def index
    @camps = Camp.all
  end

  def show; end

  def start_enrolment
    @enrolment = @camp.enrolments.find_or_create_by(user_id: current_user.id)
    session[:enrolment_id] = @enrolment.id
    if @enrolment.progress == 0
      redirect_to enrolment_path(:personal_info)
    else
      redirect_to enrolment_path(:dashboard)
    end
  end

  private
  
  def set_camp
    @camp = Camp.find_by(id: params[:id])
    redirect_to root_path if !@camp
  end
  
  def check_enrolment
    @enrolment = @camp.enrolments.find_by(user_id: current_user.id)
    start_enrolment if @enrolment
  end

  def check_date
    if @camp.start_date < Time.now
      redirect_to camps_path, alert: "This camp has already started, please select another camp"
    end
  end

  def camp_params
    params.require(:camp).permit(:name, :start_date, :end_date, :registration_date, :status, location_ids: [])
  end
end
