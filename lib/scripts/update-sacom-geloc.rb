organisations = Organisation.where(dataset: "sacom/adel-and-north").where("lat is null")
count = 0

organisations.each do |org|
  if org.lat == nil and org.long == nil
    count += 1
    geocoder = OrganisationGeocoder.new(org)

    if geocoder.save
      puts org.name
    else
      puts "could not find for #{org.name}"
    end
  end
end

puts count

