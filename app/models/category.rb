class Category < ActiveRecord::Base
  attr_accessible :name, :product_category_id
  has_many :product_categories
  has_many :products, :through => :product_categories

  def add_product(product)
    products << product
  end
end
