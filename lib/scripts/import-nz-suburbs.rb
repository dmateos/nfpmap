require 'csv'

csv_data = File.read('lib/scripts/nz-suburbs.csv')
csv = CSV.parse(csv_data, headers: false)

csv.each do |c|
  suburb = Suburb.new
  suburb.name = c[1]
  suburb.postcode = c[0]
  suburb.state = "n/a"
  suburb.lat = c[2]
  suburb.long = c[3]

  suburb.save
end
