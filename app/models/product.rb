require 'money'
require 'price'

class Product < ActiveRecord::Base
  include StoreEngine::Price 

  has_many :product_categories
  has_many :categories, :through => :product_categories
  has_many :cart_items
  attr_accessible :title, :description, :price

  def set_categories(category_ids)
    category_ids.uniq!
    categories.clear
    categories << Category.find(category_ids)
  end

  def price_string
    price.to_s
  end
end