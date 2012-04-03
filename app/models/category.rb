class Category < ActiveRecord::Base
  attr_accessible :name

  has_many :product_categories
  has_many :products, :through => :product_categories

end