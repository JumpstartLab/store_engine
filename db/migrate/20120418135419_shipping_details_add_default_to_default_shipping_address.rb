class ShippingDetailsAddDefaultToDefaultShippingAddress < ActiveRecord::Migration
  def change
    change_column_default :shipping_details, :default_shipping_address, false
  end
end
