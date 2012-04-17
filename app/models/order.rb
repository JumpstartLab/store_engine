class Order < ActiveRecord::Base
  attr_accessible :user_id, :credit_card_id
  attr_accessor :stripe_customer_token

  belongs_to :user
  belongs_to :credit_card

  has_many :order_products, :dependent => :destroy
  has_many :products, :through => :order_products
  has_one :order_status, :dependent => :destroy
  validates_presence_of :user_id

  scope :desc, order("id DESC")

  def create_pending_status
    if self.order_status.nil?
      OrderStatus.create(:status => 'pending', :order_id => self.id)
    end
  end


  def status
    result = self.order_status.status
    result ? result : ""
  end

  def mark_as_paid
    self.order_status.update_attributes(:status => 'paid')
  end

  def charge(cart)
    if credit_card.charge(cart.cart_total_in_cents)
      self.mark_as_paid
      true
    else
      false
    end
  end

  def find_credit_card
    if credit_card = user.credit_cards.find_by_stripe_customer_token(stripe_customer_token)
      self.update_attributes( :credit_card_id => credit_card.id)
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
      #Order.joins('LEFT OUTER JOIN order_statuses ON order_statuses.order_id = order_id WHERE order_statuses.status = status')
      Order.joins('LEFT OUTER JOIN order_statuses ON orders.id = order_statuses.order_id').
      where('order_statuses.status = ?', status_filter)
      #Order.find_all_by_status(status)
    end
  end

  def self.user_by_order_id(id)
    order = Order.find_by_id(id)
    order.user if order
  end
end
