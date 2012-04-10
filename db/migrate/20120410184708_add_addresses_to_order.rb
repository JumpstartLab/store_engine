class AddAddressesToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :billing_address, :text
    add_column :orders, :shipping_address, :text
  end
end
