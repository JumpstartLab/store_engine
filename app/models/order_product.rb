class OrderProduct < ActiveRecord::Base
  attr_accessible :order_id, :price_cents, :product_id, :quantity

  belongs_to :order
  belongs_to :product

  monetize :price_cents, :target_name => "price"

  def name
    product.name
  end

  def subtotal
    product.price * self.quantity
  end

  def price
    product.price #Adjust for sale price.
  end

  def price_in_cents
    product.price_cents #Adjust for sale price.
  end

end
