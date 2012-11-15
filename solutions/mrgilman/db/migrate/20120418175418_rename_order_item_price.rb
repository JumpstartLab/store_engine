class RenameOrderItemPrice < ActiveRecord::Migration
  def up
    rename_column :order_items, :price, :price_cents
  end

  def down
  end
end
