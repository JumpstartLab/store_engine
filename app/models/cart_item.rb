class CartItem < ActiveRecord::Base
  attr_accessible :cart_id, :item_id, :quantity
  belongs_to :cart

  validates_presence_of :cart_id, :item_id, :quantity
end
