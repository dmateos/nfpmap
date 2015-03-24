require 'geocoder'

Geocoder.configure(timeout: 1000)

organisations = Organisation.where(dataset: "cu-nz-orgs")
count = 0

organisations.each do |org|
  if org.lat == nil and org.long == nil
    count += 1
    geodata = Geocoder.search("#{org.address} #{org.suburb.name if org.suburb}")
    if not geodata[0].nil? and not geodata[0].address_components_of_type(:administrative_area_level_1)[0].nil?
      puts geodata[0].address_components_of_type(:administrative_area_level_1)[0].inspect

      puts org.name
      puts geodata[0].address_components.inspect
      puts geodata[0].coordinates.inspect
      org.dataset = "cu-nz-orgs/geoloc"
      org.lat = geodata[0].coordinates[0]
      org.long = geodata[0].coordinates[1]
      org.save
      sleep 1
    end
  end
end
