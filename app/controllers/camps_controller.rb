class CampsController < ApplicationController
  before_action :set_camp, only: %i[show edit update destroy start_enrolment]
  before_action :authenticate_user!
  before_action :check_date, only: [:start_enrolment]
  before_action :set_enrolment, only: [:show, :start_enrolment]
  
  def index
    @camps = Camp.all
  end

  def show
    if @enrolment.progress > 0
      start_enrolment
    end
  end

  def start_enrolment
    session[:enrolment_id] = @enrolment.id
    if @enrolment.progress == 0
      redirect_to enrolment_path(:personal_info)
    else
      redirect_to enrolment_path(:dashboard)
    end
  end

  private
  
  def set_camp
    @camp = Camp.find(params[:id])
  end

  def set_enrolment
    @enrolment = Enrolment.find_or_create_by(user_id: current_user.id, camp_id: @camp.id)
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
