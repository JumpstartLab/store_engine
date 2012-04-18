class CreditCardsRenameColumnToDefaultCard < ActiveRecord::Migration
  def change
    rename_column :credit_cards, :card_default, :default_card
  end
end
