class CartProduct < ActiveRecord::Base
  attr_accessible :cart_id, :product_id, :quantity

  belongs_to :cart
  belongs_to :product

  def name
    product.name
  end

  def subtotal
    product.price * self.quantity
  end

  def price
    product.price
  end

end
