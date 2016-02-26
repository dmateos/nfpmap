organisations = Organisation.where(dataset: "sacom/adel-and-north").where(abn: nil)

count = 0

organisations.each do |org|
  if org.abn == nil
    count += 1
    abn_adder = OrganisationAbnAdder.new(org)

    if abn_adder.save
      puts org.name
    else
      puts "could not find abn for #{org.name}"
    end
  end
end

puts count
