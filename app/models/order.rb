class Order < ActiveRecord::Base
  attr_accessible :billing_address, :shipping_address, 
                  :transactionsuser_id, :billing_address_id, 
                  :shipping_address_id, :user_id
  belongs_to :user

  validates_presence_of :user_id, :allow_nil => false

  has_many :order_products
  has_many :products, :through => :order_products
  has_many :order_statuses

  has_many :transactions
  has_many :credit_cards, :through => :transactions

  belongs_to :billing_address, :class_name => "Address"
  belongs_to :shipping_address, :class_name => "Address"

  # accepts_nested_attributes_for :billing_address, :shipping_address, :transactions

  def self.pending
    Order.all.select {|order| order.status == "pending"}
  end

  def self.paid
    Order.all.select {|order| order.status == "paid"}
  end

  def self.shipped
    Order.all.select {|order| order.status == "shipped"}
  end

  def self.cancelled
    Order.all.select {|order| order.status == "cancelled"}
  end

  def self.returned
    Order.all.select {|order| order.status == "returned"}
  end


  def status
    if order_statuses.any?
      order_statuses.last.status
    else
      order_statuses.new(:status => "pending")
      save
      return order_statuses.last.status
    end
  end

  def placed_at
    self.created_at.strftime("%I:%M %P on %m/%d/%y")
  end

  def paid_at
    stamp = self.order_statuses.find_by_status("paid")
    if stamp
      stamp.created_at.strftime("%I:%M %P on %m/%d/%y")
    else
      nil
    end
  end

  def shipped_at
    stamp = self.order_statuses.find_by_status("shipped")
    if stamp
      stamp.created_at.strftime("%I:%M %P on %m/%d/%y")
    else
      nil
    end
  end

  def returned_at
    stamp = self.order_statuses.find_by_status("returned")
    if stamp
      stamp.created_at.strftime("%I:%M %P on %m/%d/%y")
    else
      nil
    end
  end

  def cancelled_at
    stamp = self.order_statuses.find_by_status("cancelled")
    if stamp
      stamp.created_at.strftime("%I:%M %P on %m/%d/%y")
    else
      nil
    end
  end

  def add_products_by_cart_id(cart_id)
    cart = Cart.find_by_id(cart_id.to_i)
    cart.cart_products.each do |cp|
      create_order_product_from_cart_product(cp)
    end
    cart.empty
  end

  def create_order_product_from_cart_product(cart_product)
    order_product = order_products.new
    order_product.product_id = cart_product.product_id
    order_product.quantity = cart_product.quantity
    save
  end

  def billing_address
    Address.find_by_id(self.billing_address_id)
  end

  def shipping_address
    Address.find_by_id(self.shipping_address_id)
  end

  def total
    order_products.sum(&:total)
  end

end
