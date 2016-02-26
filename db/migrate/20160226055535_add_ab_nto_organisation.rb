class AddAbNtoOrganisation < ActiveRecord::Migration
  def change
    add_column :organisations, :abn, :string
  end
end
