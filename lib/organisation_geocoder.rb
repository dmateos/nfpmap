require 'geocoder'

Geocoder.configure(timeout: 1000)

class OrganisationGeocoder
  def initialize(organisation, geocoder = Geocoder)
    @organisation = organisation
    @geocoder = geocoder
  end

  def save
    if not @organisation.address
      return
    end

    geo = geocode(@organisation.full_address)

    if geo and geo[0] and geo[1]
      @organisation.lat = geo[0]
      @organisation.long = geo[1]
      @organisation.save
    end
  end

  private
  def geocode(address)
    geodata = @geocoder.search(address)
    if not geodata[0].nil? and not geodata[0].address_components_of_type(:administrative_area_level_1)[0].nil?
      if geodata[0].address_components_of_type(:administrative_area_level_1)[0]["short_name"] == "SA"
        return geodata[0].coordinates
      end
    end
  end
end
