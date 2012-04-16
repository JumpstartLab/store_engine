class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.string :stripe_customer_id
      t.timestamps
    end
  end
end
