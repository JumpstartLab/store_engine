class CreditCardAddColumns < ActiveRecord::Migration
  def change
    add_column :credit_cards, :user_id, :integer
    add_index  :credit_cards, :user_id
    add_column :credit_cards, :type, :string
    add_column :credit_cards, :last_four, :string
    add_column :credit_cards, :exp_month, :string
    add_column :credit_cards, :exp_year, :string
  end
end
