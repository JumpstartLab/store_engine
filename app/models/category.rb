class Category < ActiveRecord::Base
  attr_accessible :name

  has_many :category_products
  has_many :products, :through => :category_products
end
