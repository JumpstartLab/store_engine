class ShippingDetailRemoveUserIdAddDefaultAddress < ActiveRecord::Migration
  def change
    remove_column :shipping_details, :user_id
    add_column :shipping_details, :default_shipping_address, :boolean
  end
end
