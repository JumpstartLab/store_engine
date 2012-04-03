class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer   :product_id
      t.integer   :order_id
      t.integer   :quantity
      t.integer   :unit_price
      t.timestamps
    end
  end
end