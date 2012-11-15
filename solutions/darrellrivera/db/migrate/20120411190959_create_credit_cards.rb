class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.string :credit_card_number
      t.string :cvc
      t.string :expiration_date
      t.integer :user_id

      t.timestamps
    end
  end
end
