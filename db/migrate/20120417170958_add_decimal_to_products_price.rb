class AddDecimalToProductsPrice < ActiveRecord::Migration
  def change
    change_column :products, :price, :decimal, :scale => 2
  end
end
