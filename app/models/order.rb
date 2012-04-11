class Order < ActiveRecord::Base
  PAYMENT_TYPES = ["Check","Credit Card", "Purchase Order"]

  has_many :line_items, dependent: :destroy
  has_many :order_items
  belongs_to :user
  attr_accessible :user_id, :status, :total, :pay_type, :name, :address, :email

  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES
  validates :status, :presence => true
  # validates :user_id, :presence => true

  def next_status
    case status 
    when "pending" then "cancelled"
    when "paid" then "shipped"
    when "shipped" then "returned"
    end
  end

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  # def total
  #   line_items.sum(@line_item.total_price)
  # end

  def total
    total = 0
    line_items.each do |oi|
      total += oi.total_price
    end
    total
  end

  def self.status_hash
    status_hash = {}
    status_hash["shipped"] = Order.count(:conditions => "status = shipped")
    status_hash["pending"] = Order.count(:conditions => "status = pending")
    status_hash["cancelled"] = Order.count(:conditions => "status = cancelled")
    status_hash
  end


end
