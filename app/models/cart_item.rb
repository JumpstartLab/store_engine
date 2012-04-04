class CartItem < ActiveRecord::Base
  attr_accessible :cart_id, :product_id, :quantity
  belongs_to :cart
  belongs_to :product

  validates_presence_of :cart_id, :product_id, :quantity

  def title
    product.title
  end
end
