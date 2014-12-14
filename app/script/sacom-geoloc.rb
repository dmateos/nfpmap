organisations = Organisation.all
count = 0

organisations.each do |org|
  if org.lat == nil and org.long == nil
    puts org.name
    count += 1
  end
end

puts count

