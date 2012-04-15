class OrderItem < ActiveRecord::Base
  attr_accessible :product, :price, :quantity
  belongs_to :order
  belongs_to :product
end
