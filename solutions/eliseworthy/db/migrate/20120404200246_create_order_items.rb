class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.decimal :price
      t.integer :quantity
      t.integer :product_id
      t.timestamps
    end
  end
end
