class Order < ActiveRecord::Base
  attr_accessible :status, :user, :shipping_address, :billing_address, 
    :status_updated_at, :order_items
  belongs_to :status
  has_many :order_items
  belongs_to :shipping_address
  belongs_to :billing_address
  belongs_to :user

  def charge(transaction_id, amount)
    transaction = Transaction.find(transaction_id)

    charge = Stripe::Charge.create(
      :amount => amount, # amount in cents, again
      :currency => "usd",
      :customer => transaction.stripe_customer_id
    )
   end

  def display_date
    created_at.strftime("%m/%d/%Y - %I:%S %p")
  end
end
