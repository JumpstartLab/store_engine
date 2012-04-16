class OrderStatus < ActiveRecord::Base
  attr_accessible :status, :order_id

  belongs_to :order

  # def initialize(order_id)
  #   @order = Order.find(order_id)
  # end

  # def update_status(action)
  #   case action
  #   when 'cancelled'
  #     @order.cancelled
  #   when 'shipped'
  #     @order.shiped
  #   when 'returned'
  #     @order.returned
  #   end
  # end

end
