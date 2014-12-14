class PagesController < ApplicationController
  def index
    @organisations = Organisation.all
    @org_hash = @organisations.select{ |org|
      org.lat != nil and org.long != nil
    }.map{ |org |
      { lat: org.lat, lng: org.long, infowindow: org.name }
    }

    @org_suburb_count = @organisations.group(:suburb)
              .order('count_suburb desc')
              .limit(16)
              .count('suburb')
  end

  def sacommunity
    @organisations = Organisation.all
    @org_hash = @organisations.select{ |org|
      org.lat != nil and org.long != nil
    }.map{ |org |
      { lat: org.lat, lng: org.long, infowindow: org.name }
    }

    @org_suburb_count = @organisations.group(:suburb)
              .order('count_suburb desc')
              .limit(16)
              .count('suburb')
  end
end
