class AddOrderIdToOrderProducts < ActiveRecord::Migration
  def change
    add_column :order_products, :order_id, :integer
  end
end
