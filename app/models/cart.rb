class Cart < ActiveRecord::Base
  attr_accessible :user_id
  belongs_to :user

  has_many :cart_products
  has_many :products, :through => :cart_products
  
  def add_product_by_id(product_id)
    product = Product.find_by_id(product_id)
    products << product
  end

  def remove_product_by_id(product_id)
    product = Product.find_by_id(product_id)
    products.delete(product)
  end
end
