class AddQuantityToCartProducts < ActiveRecord::Migration
  def change
    add_column :cart_products, :quantity, :integer, :default => 1
  end
end
