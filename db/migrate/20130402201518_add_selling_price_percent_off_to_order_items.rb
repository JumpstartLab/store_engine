class AddSellingPricePercentOffToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :selling_price, :decimal, precision: 8, scale: 2
    add_column :order_items, :percent_off, :decimal, precision: 8, scale: 2
  end
end
