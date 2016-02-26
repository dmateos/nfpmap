class PagesController < ApplicationController
  def index
    #@datasets = Organisation.select(:dataset).map(&:dataset).uniq.sort
    @datasets = Organisation.where(dataset: "sacom/adel-and-north").select(:dataset).map(&:dataset).uniq.sort

    if params.has_key?(:datasets)
      @organisations = Organisation.where(dataset: params[:datasets]).includes(:suburb)
    else
      #@organisations = Organisation.all.includes(:suburb)
      @organisations = Organisation.where(dataset: "sacom/adel-and-north").includes(:suburb)
    end

    @organisations = @organisations.with_abn if params[:abn]

    case params[:group_by]
    when "suburbs"
      @org_hash = @organisations.select { |org| org.suburb }.map { |org |
        { lat: org.lat, lng: org.long, infowindow: "#{org.name} <br/> #{org.address} <br/> #{org.suburb.name if org.suburb }" }
      }
    else #lat/long
      @org_hash = @organisations.select { |org| org.lat and org.long }.map { |org |
        { lat: org.lat, lng: org.long, infowindow: "#{org.name} <br/> #{org.address} <br/> #{org.suburb.name if org.suburb }" }
      }
    end

    @org_suburb_count = @organisations.suburb_count
  end

  def suburbmap
    @suburbs = Suburb.all
    @suburb_hash = @suburbs.select { |suburb| suburb.lat and suburb.long }.map { |suburb|
      { lat: suburb.lat, lng: suburb.long, infowindow: suburb.name }
    }
    @org_suburb_count = Organisation.suburb_count
  end
end
