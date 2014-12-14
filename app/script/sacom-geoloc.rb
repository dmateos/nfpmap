require 'geocoder'

Geocoder.configure(timeout: 1000)

organisations = Organisation.all
count = 0

organisations.each do |org|
  if org.lat == nil and org.long == nil
    count += 1
    geodata = Geocoder.search(org.address)
    if not geodata[0].nil? and not geodata[0].address_components_of_type(:administrative_area_level_1)[0].nil?
      if geodata[0].address_components_of_type(:administrative_area_level_1)[0]["short_name"] == "SA"
        puts org.name
        puts geodata[0].address_components.inspect
        puts geodata[0].coordinates.inspect
        org.dataset = "sacom/geoloc"
        org.lat = geodata[0].coordinates[0]
        org.long = geodata[0].coordinates[1]
        org.save
      end
    end
  end
end

puts count

