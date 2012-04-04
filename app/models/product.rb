class Product < ActiveRecord::Base
  attr_accessible :description, :name, :photo, :price, :status

  has_many :order_products
  has_many :orders, :through => :order_products

  has_many :cart_products
  has_many :carts, :through => :cart_products

  has_one :discount

  has_many :product_categories
  has_many :categories, :through => :product_categories
end
