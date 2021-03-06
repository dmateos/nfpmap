require 'csv'

csv_data = File.read('lib/scripts/sacom-nrth.csv')
csv = CSV.parse(csv_data, headers: true)

csv.each do |c|
  org = Organisation.new

  org.name = c['Org_name']
  org.address = c['Street_Address_Line_1'] 
  org.address += c["Street_Address_Line_2"] if c["Street_Address_Line_2"]

  org.website = c['Website_1']
  org.abn = c["ABN"]
  org.lat = c['Geo_Code_1_StreetAddress_']
  org.long = c['Geo_Code_2_StreetAddress_']
  org.dataset = "sacom/adel-and-north"

  if not c['Suburb'].nil?
    suburb = Suburb.where(name: c['Suburb']).take
    org.suburb = suburb
  end

  org.save
end
