class CartItem < ActiveRecord::Base
  attr_accessible :product_id

  belongs_to :product
  belongs_to :cart
end
