class ChangeItemToProductForCartItem < ActiveRecord::Migration
  def change
    rename_column :cart_items, :item_id, :product_id
  end
end
