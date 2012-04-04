class OrderItem < ActiveRecord::Base
  attr_accessible :order_id, :product_id, :quantity

  belongs_to :order
  belongs_to :product

  validates_presence_of :order, :product_id

  def line_price
    each_price * quantity
  end

  def each_price
    product.price
  end
end
