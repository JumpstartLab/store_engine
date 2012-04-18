class OrderProduct < ActiveRecord::Base
  attr_accessible :quantity, :product_id, :order_id

  belongs_to :order
  belongs_to :product

  validates_associated :order
  validates_associated :product

  def title
    product.title
  end

  def price
    product.price
  end

  def total
    price * quantity
  end

end
