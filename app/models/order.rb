class Order < ActiveRecord::Base
  attr_accessible :user_id, :status, :stripe_customer_token
  attr_accessor :stripe_card_token

  belongs_to :user
  has_many :order_products
  has_many :products, :through => :order_products
  validates_presence_of :user_id

  def charge(cart_total_in_cents)
    #Charge must be in cents.
    # raise cart_total_in_cents.inspect
      Stripe::Charge.create(amount: cart_total_in_cents,
                            currency: 'usd',
                            customer: customer_token)
      self.update_attribute(:status, 'success')
  rescue Stripe::InvalidRequestError => e
    send_charge_error(e)
  end

  def save_customer
    if valid?
      customer = Stripe::Customer.create(description: 'test charges',
                                         card: stripe_card_token)
      self.update_attributes( :stripe_customer_token => customer.id,
                              :status => 'payment info entered' )
    end
  rescue Stripe::InvalidRequestError => e
    send_customer_create_error(e)
  end

  def order_total
    order_products.inject(Money.new(0, "USD")) do |total, order_product|
      total + order_product.price * order_product.quantity
    end
  end

private

  def send_charge_error(e)
    logger.error "Stripe error while charging customer: #{e.message}"
    errors.add :base, "There was a problem with the charge."
    false
  end

  def send_customer_create_error(e)
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

  def customer_token
    self.stripe_customer_token
  end

end
