class CartProduct < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product

  attr_accessible :quantity

  def title
    product.title
  end

  def total
    product.price * quantity
  end

  def unit_price
    product.price
  end

end
