class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart
  belongs_to :order
  attr_accessible :cart_id, :product_id, :product

  def total_price
    product.price * quantity
  end
end
