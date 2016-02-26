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

    if params[:abn]
      @organisations = @organisations.where.not(abn: nil)
    end

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

    @org_suburb_count = @organisations
              .joins(:suburb)
              .group('suburbs.name')
              .order('count_suburb_id desc')
              .limit(16)
              .count('suburb_id')
  end

  def suburbmap
    @suburbs = Suburb.all
    @suburb_hash = @suburbs.select { |suburb| suburb.lat and suburb.long }.map { |suburb|
      { lat: suburb.lat, lng: suburb.long, infowindow: suburb.name }
    }

    @org_suburb_count = Organisation.all
              .joins(:suburb)
              .group('suburbs.name')
              .order('count_suburb_id desc')
              .limit(16)
              .count('suburb_id')
  end
end
