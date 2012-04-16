class Order < ActiveRecord::Base
  attr_accessible :user_id, :status, :credit_card_id
  attr_accessor :stripe_card_token

  belongs_to :user
  belongs_to :credit_card

  has_many :order_products, :dependent => :destroy
  has_many :products, :through => :order_products
  validates_presence_of :user_id

  scope :desc, order("id DESC")

  def stripe_create_customer
    if stripe_card_token.blank?
      logger.error "Stripe error while creating customer: No card token present"
      errors.add :base, "There was a problem with your credit card."
      return false
    end

    Stripe::Customer.create( description: "Mittenberry Order #{id}",
                                      card: stripe_card_token)

  rescue Stripe::InvalidRequestError => e
    send_customer_create_error(e)
  end

  def mark_as_paid
    update_attribute(:status, 'paid')
  end

  def charge(cart)
    if credit_card.charge(cart.cart_total_in_cents)
      @order.mark_as_paid
      true
    else
      false
    end
  end

  def save_credit_card
    if valid?
      customer_token = stripe_create_customer
      credit_card = CreditCard.create_from_stripe_token(customer_token)
      if credit_card.add_user_to_credit_card(user)
        self.update_attributes( :status => 'payment info entered',
                                :credit_card_id => credit_card.id )
      end
    end
  rescue Stripe::InvalidRequestError => e
    send_customer_create_error(e)
  end

  def order_total
    order_products.inject(Money.new(0, "USD")) do |total, order_product|
      total + order_product.price * order_product.quantity
    end
  end

  def self.orders_by_filter(status)
    if status.nil?
      Order.all
    else
      Order.find_all_by_status(status)
    end
  end

  def self.user_by_order_id(id)
    order = Order.find_by_id(id)
    order.user if order
  end

private

  def send_customer_create_error(e)
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

end
