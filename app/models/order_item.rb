class OrderItem < ActiveRecord::Base
  attr_accessible :quantity, :unit_price, :product_id

  has_one :product
end