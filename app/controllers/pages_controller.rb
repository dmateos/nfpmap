class PagesController < ApplicationController
  def index
    @organisations = Organisation.all
    @org_hash = @organisations.select { |org|
      org.lat != nil and org.long != nil
    }.map{ |org |
      { lat: org.lat, lng: org.long, infowindow: org.name }
    }

    @org_suburb_count = @organisations
              .joins(:suburb)
              .group('suburbs.name')
              .order('count_suburb_id desc')
              .limit(16)
              .count('suburb_id')
  end

  def suburbmap
    @suburbs = Suburb.all
    @suburb_hash = @suburbs.select { |suburb|
      suburb.lat != nil and suburb.long != nil
    }.map { |suburb|
      { lat: suburb.lat, lng: suburb.long, infowindow: suburb.name }
    }

    @org_suburb_count = Organisation.all
              .joins(:suburb)
              .group('suburbs.name')
              .order('count_suburb_id desc')
              .limit(16)
              .count('suburb_id')
  end

  def orgssuburbmap

  end
end
