class OrderItemsQuantityRename < ActiveRecord::Migration
  def change
    rename_column :order_items, :product_quantity, :quantity
  end
end
