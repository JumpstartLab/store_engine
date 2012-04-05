class CreateOrderProducts < ActiveRecord::Migration
  def change
    create_table :order_products, :id => false do |t|
      t.references :order, :null => false
      t.references :product, :null => false
      t.integer :price_in_cents
      
      t.timestamps
    end
  end
end
