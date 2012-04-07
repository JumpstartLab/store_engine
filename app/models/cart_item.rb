class CartItem < ActiveRecord::Base
  attr_accessible :product, :cart

  belongs_to :product
  belongs_to :cart
end
