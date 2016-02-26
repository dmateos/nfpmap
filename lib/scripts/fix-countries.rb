Organisation.where(dataset: "cu-nz-orgs").each do |org|
  if org.suburb
    new_suburb = Suburb.where(name: org.suburb.name).where(state: "n/a").first
    if new_suburb
      org.suburb_id = new_suburb.id
      org.save
    end
  end
end
