class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :stripe_card_token
      t.integer :user_id
      t.string :stripe_customer_id
      t.timestamps
    end
  end
end
