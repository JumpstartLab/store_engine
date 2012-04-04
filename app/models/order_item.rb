class OrderItem < ActiveRecord::Base
  attr_accessible :quantity, :unit_price, :product_id

  belongs_to :product
  belongs_to :order
end