class Organisation < ActiveRecord::Base
  belongs_to :suburb

  def full_address
    if suburb
      "#{address}, #{suburb.name}, #{suburb.state}, #{suburb.postcode}"
    else
      "#{address}"
    end
  end
end
