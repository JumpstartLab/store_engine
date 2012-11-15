class AddBillingAddressIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :billing_address_id, :integer
  end
end
