class Admin::CampsController < AdminController
  before_action :set_camp, only: %i[ show edit update destroy ]
  
  def index
    if params[:query].present?
      @pagy, @camps = pagy(Camp.global_search(params[:query]).order(created_at: :asc), items: 3)
    else
      @pagy, @camps = pagy(Camp.order(created_at: :asc), items: 3)
    end
    respond_to do |format|
      format.html
      format.csv { send_data Camp.all.to_csv, filename: "Camps-#{Date.today}.csv" }
    end
  end

  def new
    @camp = Camp.new

    respond_to do |format|
      format.js
      format.html 
    end 
  end

  def destroy
    @camp.destroy
    
    respond_to do |format|
      format.js
    end  
  end

  private
  
  def set_camp
    @camp = Camp.find(params[:id])
  end
end
