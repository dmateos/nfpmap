class PagesController < ApplicationController
  def index
    @organisations = Organisation.where(dataset: params[:datasets]).includes(:suburb)

    case params[:group_by]
      when "lat/long"
        @org_hash = @organisations.select { |org| org.lat and org.long }.map { |org |
          { lat: org.lat, lng: org.long, infowindow: "#{org.name} <br/> #{org.address} <br/> #{org.suburb.name if org.suburb }" }
        }
      when "suburbs"
        @org_hash = @organisations.select { |org| org.suburb }.map { |org |
          { lat: org.suburb.lat, lng: org.suburb.long, infowindow: "#{org.name} <br/> #{org.address} <br/> #{org.suburb.name if org.suburb }" }
        }
    end

    @adelaide = Suburb.find_by_name("Adelaide")
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
