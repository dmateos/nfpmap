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
end
