class Category < ActiveRecord::Base
  attr_accessible :title

  has_many :products, :through => :product_categories
end
