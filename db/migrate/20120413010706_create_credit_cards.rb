class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.string :credit_card_number
      t.string :expiration_month
      t.string :expiration_year
      t.string :credit_card_verification_number
      t.string :cardholder_name
      t.timestamps
    end
  end
end
