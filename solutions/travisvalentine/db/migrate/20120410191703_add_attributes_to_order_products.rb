class AddAttributesToOrderProducts < ActiveRecord::Migration
  def change
    add_column :order_products, :quantity, :integer
    add_column :order_products, :product_id, :integer
  end
end
