class AddOrderIdToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :order_id, :integer
  end
end
