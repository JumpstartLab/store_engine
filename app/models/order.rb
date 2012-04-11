class Order < ActiveRecord::Base
  attr_accessible :user_id, :status
  has_many :order_items
  has_many :products, :through => :order_items

  belongs_to :cart

  def self.create_from_cart(cart)
    order = Order.create(:status => "pending")
    order_items = cart.order_items
    order.save
    order
  end

  def add_product(product)
    if products.include?(product)
      increment_quantity_for(product)
    else
      products << product
    end
  end

  def increment_quantity_for(product)
    oi = OrderItem.find_by_product_id(product.id)
    oi.update_attribute(:quantity, oi.quantity + 1)
  end

  def total
    total_price = 0

    products.each do |product|
      total_price += subtotal(product)
    end
    total_price
  end

  def subtotal(product)
    oi = OrderItem.find_by_product_id(product.id)
    oi.quantity * oi.product.price
  end

  def quantity_for(product)
    oi = OrderItem.find_by_product_id(product.id)
    oi.quantity
  end

  def items
    order_items
  end
end
