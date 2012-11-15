class CreateOrderProducts < ActiveRecord::Migration
  def change
    create_table :order_products do |t|
      t.references :order, :null => false
      t.references :product, :null => false
      t.integer :price_in_cents
      t.integer :quantity, :default => 1
      t.integer :percent_off, :default => 0
      
      t.timestamps
    end
  end
end
