class PagesController < ApplicationController
  def index
    if params.has_key?(:datasets)
      @organisations = Organisation.where(dataset: params[:datasets]).includes(:suburb)
    else
      @organisations = Organisation.all.includes(:suburb)
    end

    case params[:group_by]
      when "suburbs"
        @org_hash = @organisations.select { |org| org.suburb }.map { |org |
          { lat: org.suburb.lat, lng: org.suburb.long, infowindow: "#{org.suburb.name}" }
        }
      else #lat/long
        @org_hash = @organisations.select { |org| org.lat and org.long }.map { |org |
          #{ lat: org.lat, lng: org.long, infowindow: "#{org.name} <br/> #{org.address} <br/> #{org.suburb.name if org.suburb }" }
          { lat: org.lat, lng: org.long, infowindow: "#{org.suburb.name if org.suburb }" }
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
