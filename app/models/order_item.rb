class OrderItem < ActiveRecord::Base
  attr_accessible :order_id, :product_id, :quantity
end
