require 'csv'

csv_data = File.read('app/script/sacom.csv')
csv = CSV.parse(csv_data, headers: true)

csv.each do |c|
  org = Organisation.new

  org.name = c['Org_name']
  org.address = c['Street_Address_Line_1']
  org.suburb = c['Suburb']
  org.state = c['State']
  org.postcode = c['Postal_Code']
  org.website = c['Website_1']
  org.lat = c['Geo_Code_1_StreetAddress_']
  org.long = c['Geo_Code_2_StreetAddress_']
  org.dataset = "sacom"

  org.save
end
