class Category < ActiveRecord::Base
  attr_accessible :name, :products

  has_many :products, :through => :category_products
end
