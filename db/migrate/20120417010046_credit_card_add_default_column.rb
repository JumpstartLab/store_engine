class CreditCardAddDefaultColumn < ActiveRecord::Migration
  def change
    add_column :credit_cards, :card_default, :boolean
    change_column_default :credit_cards, :card_default, 'false'
  end
end
