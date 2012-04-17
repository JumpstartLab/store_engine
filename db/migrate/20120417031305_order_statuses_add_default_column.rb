class OrderStatusesAddDefaultColumn < ActiveRecord::Migration
  def change
    change_column_default :order_statuses, :status, 'pending'
  end
end
