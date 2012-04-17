class Order < ActiveRecord::Base
  PAYMENT_TYPES = ["Check","Credit Card", "Purchase Order"]

  has_many :order_items
  belongs_to :user
  attr_accessible :user_id, :user, :status, :total, :pay_type, :name, :address, :email, :order_items, :cancelled_at

  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES
  validates :status, :presence => true
  validates :user_id, :presence => true

  def next_status
    case status 
    when "pending" then status = "cancelled"
    #Order.cancelled_at = Time.now
    when "paid" then status = "shipped"
    #Order.shipped_at = Time.now
    when "shipped" then "returned"
    end
  end

  def self.one_click_order(product, user)
    order_item = OrderItem.new
    order = Order.new(user: user)
    order_item.set_price_from_product(product)
    order_item.product = product
    order_item.quantity = 1
    order_item.order = order
    order_item.save
    order.name = user.orders.last.name
    order.email = user.orders.last.email
    order.address = user.orders.last.address
    order.pay_type = user.orders.last.pay_type
    order.save

    order
  end


  def add_contents_of_cart(cart, order)
    cart.line_items.each do |line_item|
      order_item = OrderItem.new
      order_item.set_price(line_item)
      order_item.set_product(line_item)
      order_item.set_quantity(line_item)
      order_item.order_id = order.id
      order_item.save
    end
  order.order_items
  end

  # def total
  #   line_items.sum(@line_item.total_price)
  # end

  def total
    total = 0
    order_items.each do |order_item|
      total += order_item.subtotal
    end
    total
  end

  def self.count_status(status)
    Order.all.count{ |order| order.status == status }
  end
end
