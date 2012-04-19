class SplitBililngExpirationDate < ActiveRecord::Migration
  def up
    add_column :billing_methods, :month, :integer
    add_column :billing_methods, :year, :integer
    remove_column :billing_methods, :credit_card_expiration_date
  end

  def down
    remove_column :billing_methods, :month
    remove_column :billing_methods, :year
    add_column :billing_methods, :credit_card_expiration_date, :integer
  end
end
