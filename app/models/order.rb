class Order < ActiveRecord::Base
  has_many :order_items, :dependent => :destroy
  has_many :products, :through => :order_items
  belongs_to :user

  def create_and_order_item_to_order(cart)
    cart.cart_items.each do |cart_item|
      order_item = OrderItem.new
      order_item.order_id = new_order.id
      order_item.product_id = cart_item.product_id
      order_item.quantity = cart_item.quantity
      order_item.total_price = cart_item.total
      order_item.save
    end

  def self.create_order_from_cart(cart_id)
    cart = Cart.find(cart_id)
    new_order = Order.create
    
    new_order.total_price = cart.total
    new_order.user
    new_order.save
    return new_order
  end

  def total
    @total ||= order_items.inject(0) do |sum, order_item|
      sum += order_item.total_price
    end
  end

  # def add_product(product)
  #   products << product
  # end

  # def add_product_by_id(product_id)
  #   product = Product.find(product_id)
  #   add_product(product)
  # end
end
