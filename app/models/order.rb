class Order < ActiveRecord::Base
  attr_accessible :user_id, :customer_id
  has_many :order_products
  has_many :products, :through => :order_products

  def add_product(product)
    if products.include?(product)
      increment_quantity_for(product)
    else
      products << product
    end
  end

  def increment_quantity_for(product)
    op = OrderProduct.find_by_product_id(product.id)
    op.update_attribute(:quantity, op.quantity + 1)
  end

  def total
    total_price = 0

    products.each do |product|
      total_price += subtotal(product)
    end
    total_price
  end

  def subtotal(product)
    op = OrderProduct.find(product.id)
    op.quantity * op.product.price
  end
end
