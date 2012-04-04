class Product < ActiveRecord::Base
  has_many :categories
  has_many :cart_items
  attr_accessible :title, :description, :price
end
