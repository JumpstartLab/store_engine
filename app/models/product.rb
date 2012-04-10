require 'money'

class Product < ActiveRecord::Base
  has_many :product_categories
  has_many :categories, :through => :product_categories
  has_many :cart_items
  attr_accessible :title, :description, :price
  monetize :price_cents

  def set_categories(category_ids)
    category_ids.uniq!
    categories.clear
    categories << Category.find(category_ids)
  end
end