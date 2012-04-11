class Category < ActiveRecord::Base
  attr_accessible :name, :product_ids

  has_many :category_products
  has_many :products, :through => :category_products

  def add_product(product)
    products << product
  end

  def add_product_by_id(product_id)
    product = Product.find(product_id)
    add_product(product)
  end
end
