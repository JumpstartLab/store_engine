class Category < ActiveRecord::Base
  attr_accessible :name, :product_ids

  has_many :category_products
  has_many :products, :through => :category_products
end
