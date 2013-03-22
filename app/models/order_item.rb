class OrderItem < ActiveRecord::Base
  belongs_to :order
  has_one :product
  attr_accessible :quantity, :unit_price
end
