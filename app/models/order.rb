class Order < ActiveRecord::Base
  #attr_accessible

  has_many :order_items
  has_many :products, :through => :order_items

  belongs_to :user

  def create_order_by_cart_id(cart_id)
    cart = Cart.find(cart_id)
    new_order = Order.new
    new_order.save
    cart.cart_items.each do |cart_item|
      order_item = OrderItem.new
      order_item.order_id = new_order.id
      order_item.product_id = cart_item.product_id
      order_item.product_quantity = cart_item.quantity
      order_item.total_price = cart_item.total
      order_item.save
    end
    return new_order
  end

  def add_product(product)
    products << product
  end

  def add_product_by_id(product_id)
    product = Product.find(product_id)
    add_product(product)
  end
end
