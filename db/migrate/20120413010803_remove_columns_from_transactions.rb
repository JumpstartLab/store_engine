class RemoveColumnsFromTransactions < ActiveRecord::Migration
  def change
    remove_column :transactions, :credit_card_number
    remove_column :transactions, :expiration_month
    remove_column :transactions, :expiration_year
    remove_column :transactions, :credit_card_verification_number
    remove_column :transactions, :cardholder_name
    remove_column :transactions, :status
    remove_column :transactions, :order_id
  end
end
