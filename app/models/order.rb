class Order < ActiveRecord::Base
  attr_accessible :user_id, :customer_id
  has_many :order_products
  has_many :products, :through => :order_products

  def add_product(product)
    OrderProduct.create(:order_id => id, :product_id => product.id)
  end

  def total
    products.map do |product|
      product.price
    end.inject(&:+)
  end


end
