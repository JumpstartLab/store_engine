# Connects categories to products
class CategoryProduct < ActiveRecord::Base
  belongs_to :category
  belongs_to :product
end
