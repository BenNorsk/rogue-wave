class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
    change_table :addresses do |column|
      column.rename :long, :longitude
      column.rename :lat, :latitude
  end
end
end
