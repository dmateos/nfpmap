class CreateOrganisations < ActiveRecord::Migration
  def change
    create_table :organisations do |t|
      t.string :name
      t.string :address
      t.string :state
      t.string :suburb
      t.string :postcode
      t.string :website
      t.string :dataset
      t.float :lat
      t.float :long

      t.timestamps
    end
  end
end
