class AddForeignKeysToOrderProducts < ActiveRecord::Migration
  def change
    add_column(:order_products, :shopping_cart_id, :integer)
    add_column(:order_products, :order_id, :integer)
    add_column(:order_products, :product_id, :integer)
  end
end
