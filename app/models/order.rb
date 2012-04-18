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

  def update_status
    case status.name
    when StoreEngine::Status::PENDING
      update_attributes(:status => 
                        Status.find_by_name(StoreEngine::Status::CANCELLED))
    when StoreEngine::Status::SHIPPED
      update_attributes(:status => 
                        Status.find_by_name(StoreEngine::Status::RETURNED))
    when StoreEngine::Status::PAID
      update_attributes(:status => 
                        Status.find_by_name(StoreEngine::Status::SHIPPED))
    end
  end

  def total
    order_items.inject(Money.new(0)) do |sum, order_item|
      sum += order_item.price * order_item.quantity
    end
  end
end
