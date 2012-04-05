class OrderItem < ActiveRecord::Base
  belongs_to :product
  attr_accessible :order_id, :price, :product_id, :quantity, :subtotal

  def before_update
    self.subtotal = price * quantity
  end

  def before_create
    self.price = product.price
  end

end