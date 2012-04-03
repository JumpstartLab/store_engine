class OrderProduct < ActiveRecord::Base
  belongs_to :shopping_cart
  belongs_to :order
  has_one :product
  attr_accessible :quantity, :price
end
