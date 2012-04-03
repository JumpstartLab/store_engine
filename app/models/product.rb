class Product < ActiveRecord::Base
  has_many :categories
  attr_accessible :title, :description, :price
end
