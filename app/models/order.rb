class Order < ActiveRecord::Base
  attr_accessible :user_id, :credit_card_id, :order_products

  belongs_to :user
  belongs_to :credit_card

  has_many :order_products, :dependent => :destroy
  has_many :products, :through => :order_products
  has_one :order_status, :dependent => :destroy

  has_one :order_shipping_detail
  has_one :shipping_detail, :through => :order_shipping_detail
  validates_presence_of :user_id
  validates_presence_of :order_products

  #after_initialize... always runs even when recalling from database. check if order_status is nil?
  #before_create... only happens once.

  before_create :make_new_order_status

  scope :desc, order("id DESC")

  def make_new_order_status
    self.build_order_status
  end

  def status
    result = self.order_status.status
    result ? result : ""
  end

  def mark_as_paid
    self.order_status.update_attributes(:status => 'paid')
  end

  def build_order_from_cart(cart)
    if cart.has_products?
      cart.cart_products.each do |cart_prod|
        self.order_products.build(:price_cents => cart_prod.price_in_cents,
                                  :product_id => cart_prod.product_id,
                                  :quantity => cart_prod.quantity)    
      end
    end
  end

  def charge(cart)
    if credit_card.charge(cart.cart_total_in_cents)
      mark_as_paid
      true
    else
      false
    end
  end

  def set_cc_from_stripe_customer_token(stripe_customer_token)
    if credit_card = user.credit_cards.find_by_stripe_customer_token(stripe_customer_token)
      self.credit_card = credit_card
    end
  end

  def order_total
    order_products.inject(Money.new(0, "USD")) do |total, order_product|
      total + order_product.price * order_product.quantity
    end
  end

  def self.orders_by_status(status_filter=nil)
    if status_filter.nil?
      Order.all
    else
      Order.joins(:order_status).
        where('order_statuses.status = ?', status_filter)
    end
  end

  def self.user_by_order_id(id)
    order = Order.find_by_id(id)
    order.user if order
  end
end
