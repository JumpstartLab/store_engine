class AddPriceToCartProducts < ActiveRecord::Migration
  def change
    add_column :cart_products, :price, :decimal, :scale => 2, :precision => 10
  end
end
