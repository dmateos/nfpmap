class OrganisationAbnAdder
  def initialize(organisation, abn_adder = AbnLookup.new)
    @organisation = organisation
    @abn_adder = abn_adder
  end

  def save
    @abn = lookup_abn(@organisation.name, @organisation.suburb.postcode) if @organisation.suburb 

    if @abn
      @organisation.abn = @abn
      @organisation.save
    end
  end

  private
  def lookup_abn(name, postcode)
    @abn_adder.find(:name, name: name, postcode: postcode) 
  end
end
