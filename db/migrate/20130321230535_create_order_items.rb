class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references :order
      t.references :product
      t.integer :quantity
      t.decimal :unit_price, precision: 8, scale: 2

      t.timestamps
    end
    add_index :order_items, :order_id
    add_index :order_items, :product_id
  end
end
