class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :line_item
  has_one :product, through: :line_item
  attr_accessible :order_id, :price, :quantity, :subtotal, :line_item, :id, :order, :product

  def set_price(line_item)
    self.price = line_item.product.price
  end

  def set_quantity(line_item)
    self.quantity = line_item.quantity
  end

  def subtotal
    self.price * self.quantity
  end
  
end