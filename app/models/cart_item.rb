class CartItem < ActiveRecord::Base
  attr_accessible :product_id, :quantity

  belongs_to :product
  belongs_to :cart

  def price
    quantity * product.price
  end
end
