class OrderItem < ActiveRecord::Base
  belongs_to :product
  attr_accessible :order_id, :price, :product_id, :quantity, :total

  def subtotal
    price * quantity
  end
end
