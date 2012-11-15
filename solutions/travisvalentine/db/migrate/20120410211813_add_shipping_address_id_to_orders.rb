class AddShippingAddressIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :shipping_address_id, :integer
  end
end