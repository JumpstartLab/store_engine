require 'money'

class Product < ActiveRecord::Base
  has_many :categories
  has_many :cart_items
  attr_accessible :title, :description, :price
  monetize :price_cents
end
