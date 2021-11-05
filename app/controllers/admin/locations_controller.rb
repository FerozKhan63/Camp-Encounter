class Admin::LocationsController < AdminController
  before_action :set_location, only: %i[ edit update destroy ]
  helper_method :sort_column, :sort_direction

  def index 
    if params[:query].present?
      @pagy, @locations = pagy(Location.global_search(params[:query]).order(sort_column + " " + sort_direction), items: 3)
    else
      @pagy, @locations = pagy(Location.order(sort_column + " " + sort_direction), items: 3)
    end
    respond_to do |format|
      format.html
      format.csv { send_data Location.all.to_csv, filename: "Locations-#{Date.today}.csv" }
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

  def edit
  end

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
  end

  def location_params
    params.require(:location).permit(:name)
  end

  def sort_column
    Location.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
