class CreateBoats < ActiveRecord::Migration[6.0]
  def change
    create_table :boats do |t|
      t.text :description
      t.float :price_per_day

      t.timestamps
    end
  end
end
