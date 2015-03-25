class SuburbsController < ApplicationController
  def index
    @suburbs = Suburb.page(params[:page])
  end

  def new
  end

  def edit
  end

  def show
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
end
