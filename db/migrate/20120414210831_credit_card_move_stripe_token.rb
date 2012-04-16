class CreditCardMoveStripeToken < ActiveRecord::Migration
  def change
    remove_column :orders, :stripe_customer_token, :string
    add_column :credit_cards, :stripe_customer_token, :string
  end
end
