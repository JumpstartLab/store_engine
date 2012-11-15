class CartItem < ActiveRecord::Base
  attr_accessible :product_id, :quantity

  validates_numericality_of :quantity

  belongs_to :product
  belongs_to :cart

  def price
    quantity * product.price
  end

  def individual_price
    product.price
  end
end
