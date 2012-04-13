class AddDefaultsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :default_billing_address_id, :integer
    add_column :users, :default_shipping_address_id, :integer
    add_column :users, :default_credit_card_id, :integer
  end
end
