class CreateOrganisations < ActiveRecord::Migration
  def change
    create_table :organisations do |t|
      t.string :name
      t.string :address
      t.string :website
      t.string :dataset
      t.float :lat
      t.float :long

      t.references :suburb
      t.timestamps
    end
  end
end
