class Organisation < ActiveRecord::Base
  belongs_to :suburb

  scope :with_abn, -> { where.not(abn: nil) }
  scope :suburb_count, -> { joins(:suburb).group("suburbs.name").order("count_suburb_id desc").limit(16).count("suburb_id") }

  def full_address
    suburb ?  "#{address}, #{suburb.name}, #{suburb.state}, #{suburb.postcode}" : "#{address}"
  end
end
