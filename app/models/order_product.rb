class OrderProduct < ActiveRecord::Base
  attr_accessible :order_id, :price, :product_id, :quantity
end
