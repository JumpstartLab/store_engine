class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :credit_card_number
      t.string :expiration_month
      t.string :expiration_year
      t.string :credit_card_verification_number
      t.string :cardholder_name
      t.string :status
      t.timestamps
    end
  end
end
