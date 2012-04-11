class Order < ActiveRecord::Base
  attr_accessible :user_id, :status
  attr_accessor :stripe_card_token

  belongs_to :user
  has_many :order_products
  has_many :products, :through => :order_products

  def charge(cart)
    #Charge must be in cents.
    Stripe::Charge.create(amount: cart.cart_total_in_cents,
                          currency: 'usd',
                          customer: self.stripe_customer_token)
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while charging customer: #{e.message}"
    errors.add :base, "There was a problem with the charge."
    false
  end

  def save_customer
    if valid?
      customer = Stripe::Customer.create(description: 'test charges', card: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

end
