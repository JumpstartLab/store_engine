class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart
  has_one :order_item
  attr_accessible :product_id, :product, :quantity
  validates :quantity, :presence => true
  validates_numericality_of :quantity, :greater_than_or_equal_to => 1



  def subtotal
    self.product.price * quantity
  end
end
