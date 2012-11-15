class ChangeBillingFormat < ActiveRecord::Migration
  def up
    change_column :billing_methods, :credit_card_expiration_date, :string
    change_column :billing_methods, :credit_card_number, :string
    change_column :billing_methods, :zipcode, :string
  end

  def down
    change_column :billing_methods, :credit_card_expiration_date, :integer
    change_column :billing_methods, :credit_card_number, :integer
    change_column :billing_methods, :zipcode, :integer
  end
end
