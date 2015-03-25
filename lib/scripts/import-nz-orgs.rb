require 'csv'

csv_data = File.read("lib/scripts/nz-orgs.csv")
csv = CSV.parse(csv_data, headers: true)

csv.each do |c|
  org = Organisation.new

  org.name = c['Organization Name']
  org.address = "#{c["Main-Street Address"]}, #{c["Main-Supplemental Address 1"]}, #{c["Main-Supplemental Address 2"]}, #{c["Main-Postal Code"]}, New Zealand"
  org.website = ""
  org.dataset = "cu-nz-orgs"

  if not c["Main-City"].nil?
    suburb = Suburb.where(name: c["Main-City"]).take
    org.suburb = suburb
  end

  org.save
end
