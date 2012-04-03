class Product < ActiveRecord::Base
  attr_accessible :title, :description, :price
  has_many :orders
end
