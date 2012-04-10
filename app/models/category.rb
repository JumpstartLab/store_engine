class Category < ActiveRecord::Base
  attr_accessible :title

  has_many :product_categories
  has_many :products, :through => :product_categories
end
