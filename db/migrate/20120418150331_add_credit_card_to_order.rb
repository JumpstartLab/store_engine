class AddCreditCardToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :credit_card, :string
  end
end
