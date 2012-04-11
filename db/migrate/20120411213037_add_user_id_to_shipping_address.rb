class AddUserIdToShippingAddress < ActiveRecord::Migration
  def change
    add_column :shipping_addresses, :user_id, :integer
  end
end
