class CreditCardRenameColumnType < ActiveRecord::Migration
  def change
    rename_column :credit_cards, :type, :credit_card_type
  end
end
