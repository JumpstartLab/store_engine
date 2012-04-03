class CreateOrderProducts < ActiveRecord::Migration
  def change
    create_table :order_products do |t|
      t.integer :quantity
      t.integer :price
      t.timestamps
    end
  end
end
