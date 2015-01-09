require 'csv'

csv_data = File.read('app/script/au-suburbs.csv')
csv = CSV.parse(csv_data, headers: false)

csv.each do |c|
  suburb = Suburb.new
  suburb.name = c[2]
  suburb.postcode = c[1]
  suburb.state = c[4]
  suburb.lat = c[9]
  suburb.long = c[10]

  suburb.save
end
