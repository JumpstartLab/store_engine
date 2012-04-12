class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references :product
      t.references :order
      t.integer :price
      t.integer :quantity
      t.timestamps
    end
  end
end
