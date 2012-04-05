class OrderItemsRenameTotalToSubtotal < ActiveRecord::Migration
  def change
    rename_column :order_items, :total, :subtotal
  end

end
