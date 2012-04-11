class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product

  def title
    product.title
  end

  def total
    product.price * quantity
  end
end
