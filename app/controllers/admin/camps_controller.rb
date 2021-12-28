class Admin::CampsController < AdminController
  include PagySearch
  
  before_action :set_camp, only: %i[show edit update destroy toggle_status]
  helper_method :sort_column, :sort_direction
  
  def index
    @pagy, @camps = pagy_sort_filter(params[:query], Camp)

    respond_to do |format|
      format.html
      format.csv { send_data ExportToCsvService.new(Camp).call, filename: "Camps-#{Date.today}.csv" }
    end
  end

  def show; end

  def new
    @camp = Camp.new

    respond_to do |format|
      format.js
      format.html 
    end 
  end

  def create
    @camp = Camp.new(camp_params)

    if @camp.save
      redirect_to admin_camps_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @camp.update(camp_params)
      redirect_to admin_camps_path
    else
      render 'edit'
    end
  end

  def destroy
    @camp.destroy

    respond_to do |format|
      format.js
    end  
  end

  def toggle_status
    if @camp.active?
      @camp.inactive!
    else
      @camp.active!
    end
    @camp.save
  end

  private
  
  def set_camp
    @camp = Camp.find_by(id: params[:id])
    redirect_to admin_camps_path unless @camp
  end

  def camp_params
    params.require(:camp).permit(:name, :start_date, :end_date, :registration_date, :cost, :status, location_ids: [])
  end
  
  def sort_column
    Camp.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
end
