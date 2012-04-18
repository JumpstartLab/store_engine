class AddCreditCardToUser < ActiveRecord::Migration
  def change
    add_column :users, :credit_card, :string
  end
end
