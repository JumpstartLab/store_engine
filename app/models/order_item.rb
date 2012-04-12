class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :line_item
  attr_accessible :order_id, :price, :product_id, :quantity, :subtotal, :line_item, :id

  def price
    @price ||= self.line_item.price
  end

  def quantity 
    @quantity ||= self.line_item.quantity
  end

  def subtotal
    @subtotal ||= price * quantity
  end
  
end