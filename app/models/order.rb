class Order < ActiveRecord::Base
  attr_accessible :status, :total_price, :user, :products, :address_attributes, :address, :address_id
  attr_accessor :stripe_card_token
  attr_accessible :stripe_card_token

  has_many :order_items
  has_many :products, through: :order_items
  
  belongs_to :user
  belongs_to :address
  has_one :status


  accepts_nested_attributes_for :address
  
  def total_price
    order_items.inject(0) do |result, item|
      result += item.unit_price * item.quantity
    end
  end

  def total_price_in_cents
    total_price * 100
  end

  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(description: user.email,
      card: stripe_card_token)

      Stripe::Charge.create(
        :amount => total_price_in_cents.to_i,
        :currency => "usd",
        :customer => customer.id,
        :description => "order##{id}" )

      save!
    end
    rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
  end

  def add_order_items_from(cart)
  	cart.cart_items.each do |item|
  		oi = OrderItem.new(	quantity: item.quantity,
  							unit_price: item.individual_price,
  							order_id: self.id)
  		oi.product = item.product
  		oi.save
  	end
  end

  def current_status
    status.name
  end
end