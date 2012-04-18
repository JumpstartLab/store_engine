class OrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order

  def self.build_from_cart_item(cart_item)
    order_item = new
    order_item.product_id = cart_item.product_id
    order_item.quantity = cart_item.quantity
    order_item.total_price = cart_item.total
  end
end
