class OrderItem < ActiveRecord::Base
  belongs_to :product
  attr_accessible :order_id, :price, :product_id, :quantity, :subtotal
  before_create :set_price
  before_update :set_subtotal

  def set_price
    self.price = product.price
  end

  def set_subtotal
    self.subtotal = price * quantity
  end
  
end