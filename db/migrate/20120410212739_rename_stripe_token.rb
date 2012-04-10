class RenameStripeToken < ActiveRecord::Migration
  def change
    remove_column :orders, :stripe_card_token, :string
    add_column :orders, :stripe_customer_token, :string
  end
end
