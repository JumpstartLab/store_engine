class OrderItem < ActiveRecord::Base
  attr_accessible :quantity

  belongs_to :product
  belongs_to :order

  def title
    product.title
  end

  def total
    product.price * quantity
  end

end
