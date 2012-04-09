class FixColumnNamePriceToPriceCents < ActiveRecord::Migration
  def change
    rename_column :products, :price, :price_cents
    rename_column :order_products, :price, :price_cents
  end
end
