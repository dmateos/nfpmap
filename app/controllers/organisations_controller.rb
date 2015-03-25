class OrganisationsController < ApplicationController
  before_action :set_organisation, only: [ :show, :edit, :update, :destroy ]

  def index
    @organisations = Organisation.page(params[:page])
  end

  def show
  end

  def new
    @organisation = Organisation.new
  end

  def create
    @organisation = Organisation.new(organisation_params);
    @organisation.save
  end

  def edit
  end

  def update
    @organisation.update(organisation_params);
    redirect_to organisations_path
  end

  def destroy
  end
  
  private
  def set_organisation
    @organisation = Organisation.find(params[:id])
  end

  def organisation_params
    params.require(:organisation).permit(:name, :address, :state, :suburb, :postcode, :website, :lat, :long)
  end
end
