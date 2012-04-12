class OrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order

  # attr_accessor :product_quantity

  # def create(cart_id, order_id)
  #   cart = Cart.find(cart_id)
  #   cart.cart_items.each do |cart_item|
  #     order_item = OrderItem.new
  #     order_item.order_id = order_id
  #     order_item.product_id = cart_item.product_id
  #     order_item.quantity = cart_item.quantity
  #     order_item.total_price = cart_item.total
  #     order_item.save
  #   end
  # end

end
