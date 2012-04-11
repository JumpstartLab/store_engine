class Order < ActiveRecord::Base
  attr_accessible :status, :user, :products, :stripe_card_token

  validates_presence_of :user, :status

  belongs_to :user
  belongs_to :status

  has_many :order_products
  has_many :products, :through => :order_products

  def self.process_cart(cart)
    o = Order.new
    o.user = cart.user
    o.status = Status.find_or_create_by_name("incomplete")
    o.save
    o.convert_cart_product_to_order_product(cart.cart_products)
    o
  end

  def convert_cart_product_to_order_product(cps)
    cps.each do |cp|
      self.order_products.create(:product => cp.product, 
                                 :quantity => cp.quantity,
                                 :price_in_cents => cp.product.price_in_cents
                                )
    end
  end

  def total_price_in_cents
    order_products.sum(&:total_price_in_cents)
  end

  def total_price
    Money.new(total_price_in_cents).format
  end

  def stripe_card_token

  end

  def create_user(token)
    c = Stripe::Customer.create(
          :card => token,
          :description => user.email
        )
    user.stripe_id = c.id
    user.save
  end

  def charge(token)
    create_user(token) if !user.stripe_id
    Stripe::Charge.create(
        :amount => total_price_in_cents,
        :currency => "usd",
        :customer => user.stripe_id
      )
    self.status = Status.find_or_create_by_name("pending")
    self.user.cart.destroy
    self.save
  end

end
