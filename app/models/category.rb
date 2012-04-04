class Category < ActiveRecord::Base
  attr_accessible :name

  has_many :product_categorizations
  has_many :products, :through => :product_categorizations
end
