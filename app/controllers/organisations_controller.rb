class OrganisationsController < ApplicationController
  def index
    @organisations = Organisation.page(params[:page])
  end

  def show
    @organisation = Organisation.find(params[:id])
  end

  def new
    @organisation = Organisation.new
  end

  def create
    @organisation = Organisation.new(organisation_params);
    @organisation.save
  end

  def edit
    @organisation = Organisation.find(params[:id])
  end

  def update
    @organisation = Organisation.find(params[:id])
    @organisation.update(organisation_params);
    redirect_to organisations_path
  end

  def destroy
    @organisation = Organisation.find(params[:id])
  end

  private
  
  def organisation_params
    params.require(:organisation).permit(:name, :address, :state, :suburb, :postcode, :website, :lat, :long)
  end
end
