class OrderItem < ActiveRecord::Base
  attr_accessible :order_id, :product_id, :quantity

  belongs_to :order
  belongs_to :product

  validates :order, :product_id, presence: true
  validates :quantity, numericality: { greater_than: 0 }

  def line_price
    each_price * quantity
  end

  def each_price
    product.price
  end
end
