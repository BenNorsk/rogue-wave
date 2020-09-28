class AddNameToBoats < ActiveRecord::Migration[6.0]
  def change
    add_column :boats, :name, :string
  end
end
