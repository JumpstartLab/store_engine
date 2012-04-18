class CreateOrderShippingDetails < ActiveRecord::Migration
  def change
    create_table :order_shipping_details do |t|
      t.integer :order_id
      t.integer :shipping_details_id
      t.timestamps
    end
  end
end
