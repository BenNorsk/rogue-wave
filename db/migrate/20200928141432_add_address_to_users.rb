class AddAddressToUsers < ActiveRecord::Migration[6.0]
  def change
    # 'null: false' removed. This is added by default but we want the user's address to be optional.
    add_reference :users, :address, foreign_key: true
  end
end
