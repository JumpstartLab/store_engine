class OrderProduct < ActiveRecord::Base
  attr_accessible :quantity, :product_id, :order_id, :price

  belongs_to :order
  belongs_to :product

  validates_presence_of :price
  validates_associated :order
  validates_associated :product

  def title
    product.title
  end

  def total
    self.price * self.quantity
  end

end
