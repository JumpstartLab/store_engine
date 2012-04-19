class OrderProduct < ActiveRecord::Base
  attr_accessible :order_id, :price_cents, :product_id,
    :quantity, :product, :price

  belongs_to :order
  belongs_to :product

  monetize :price_cents, :target_name => "price"

  def name
    product.name
  end

  def subtotal
    self.price * self.quantity
  end

end
