class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :line_item
  belongs_to :product
  attr_accessible :order_id, :price,
                  :quantity, :subtotal,
                  :line_item, :id, :order, :product

  def set_price(line_item)
    self.price = line_item.product.price
  end

  def set_product(line_item)
    self.product_id = line_item.product.id
  end

  def set_quantity(line_item)
    self.quantity = line_item.quantity
  end

  def set_price_from_product(product)
    self.price = product.price
  end

  def set_product_from_product(product)
    self.product_id = product.id
  end

  def subtotal
    self.price * self.quantity
  end
end