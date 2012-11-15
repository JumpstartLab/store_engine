class OrderItem < ActiveRecord::Base
  attr_accessible :quantity, :unit_price, :product_id, :order_id

  validates_numericality_of :quantity, :greater_than => 0
  validates_numericality_of :unit_price, :greater_than => 0

  belongs_to :product
  belongs_to :order

  def price
    quantity * product.price
  end
end