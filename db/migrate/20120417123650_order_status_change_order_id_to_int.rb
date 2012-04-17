class OrderStatusChangeOrderIdToInt < ActiveRecord::Migration
  def change
    remove_column :order_statuses, :order_id
    add_column :order_statuses, :order_id, :integer
  end
end
