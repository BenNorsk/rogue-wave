class AddAddressToBoats < ActiveRecord::Migration[6.0]
  def change
    add_reference :boats, :address, null: false, foreign_key: true
  end
end
