class AddCreditCardIdAndOrderIdToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :credit_card_id, :integer
    add_column :transactions, :order_id, :integer
  end
end
