class CartItem < ActiveRecord::Base
  attr_accessible :quantity, :price, :product
  belongs_to :shopping_cart
  belongs_to :order
  belongs_to :product
end