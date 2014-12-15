class CreateSuburbs < ActiveRecord::Migration
  def change
    create_table :suburbs do |t|
      t.string :name
      t.integer :postcode
      t.string :state
      t.float :lat
      t.float :long
      t.timestamps
    end
  end
end
