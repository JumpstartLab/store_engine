class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :stripe_card_token
      t.timestamps
    end
  end
end
