class CartItem < ActiveRecord::Base
  # attr_accessible :id, :product_id, :cart_id

  belongs_to :cart
  belongs_to :product

  def title
    product.title
  end

  def total
    product.price * quantity
  end
end
