class CartItem < ActiveRecord::Base
  # attr_accessible :id, :product_id, :cart_id

  belongs_to :cart
  belongs_to :product
end
