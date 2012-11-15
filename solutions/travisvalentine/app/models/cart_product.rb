class CartProduct < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product

  attr_accessible :quantity

  def title
    product.title
  end

  def total
    self.price * self.quantity
  end

  def unit_price
    self.price
  end

end
