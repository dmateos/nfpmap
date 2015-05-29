class SuburbsController < ApplicationController
  def index
    @suburbs = Suburb.page(params[:page])
  end

  def show

  end

  def new
    @suburb = Suburb.new
  end

  def create
    @suburb = Suburb.new(suburb_params)
    @suburb.save
    respond_to do |format|
      format.html { redirect_to @suburb }
    end
  end

  def latlong
    name = params[:suburb].gsub("suburb_", "").gsub("_", " ")
    puts name
    @suburb = Suburb.find_by_name(name)

    respond_to do |format|
      format.json
      format.html
    end
  end

  private
  def suburb_params
    params.require(:suburb).permit(:name, :postcode, :state, :lat, :long)
  end
end
