class Admin::LocationsController < AdminController
  include PagySearch
  
  before_action :set_location, only: %i[edit update destroy]
  helper_method :sort_column, :sort_direction

  def index 
    (@pagy, @locations) = pagy_sort_filter(params[:query], Location)

    respond_to do |format|
      format.html
      format.csv { send_data ExportToCsvService.new(Location).call, filename: "Locations-#{Date.today}.csv" }
    end
  end

  def new
    @location = Location.new
  end
  
  def create
    @location = Location.new(location_params)
    if @location.save
      redirect_to admin_locations_path
      flash[:success] = "A new location has been added!"
    else
      flash.now[:error] = "Location needs to be unique."
      render :new
    end
  end

  def edit; end

  def update
    if @location.update(location_params)
      redirect_to admin_locations_path
    else
      render 'edit'
    end
  end

  def destroy
    @location.destroy
  end

  private

  def set_location
    @location = Location.find(params[:id])
    redirect_to admin_locations_path if !@location
  end

  def location_params
    params.require(:location).permit(:name)
  end

  def sort_column
    Location.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
end
