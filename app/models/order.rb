class Order < ActiveRecord::Base
  attr_accessible :user_id, :status
  attr_accessor :stripe_card_token

  belongs_to :user
  has_many :order_products
  has_many :products, :through => :order_products

  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(description: 'test charges', card: stripe_card_token)
      #self.stripe_customer_token = customer.id
      #save!
      Stripe::Charge.create(amount: 500, currency: 'usd', customer: customer.id)
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
end
