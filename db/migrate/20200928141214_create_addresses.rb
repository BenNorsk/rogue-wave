class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :street_address
      t.string :city
      t.string :country
      t.decimal :lat
      t.decimal :long

      t.timestamps
    end
  end
end
