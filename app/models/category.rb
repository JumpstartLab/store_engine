class Category < ActiveRecord::Base
  has_many :products, :through => :product_categories
  attr_accessible :name
end
