require 'csv'

csv_data = File.read("lib/scripts/au-orgs.csv")
csv = CSV.parse(csv_data, headers: true)

csv.each do |c|
  org = Organisation.new

  org.name = c['Organisation Name']
  org.address = "#{c["Street Address"]}, #{c["Supplemental Address 1"]}, #{c["City"]}, #{c["Post Code"]} Australia"
  org.website = ""
  org.dataset = "cu-au-orgs"

  if not c["City"].nil?
    suburb = Suburb.where(name: c["City"]).take
    org.suburb = suburb
  end

  org.save
end
