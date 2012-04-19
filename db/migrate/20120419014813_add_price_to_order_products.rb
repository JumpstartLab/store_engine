class AddPriceToOrderProducts < ActiveRecord::Migration
  def change
    add_column :order_products, :price, :decimal, :scale => 2, :precision => 10
  end
end
