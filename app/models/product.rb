class Product < ActiveRecord::Base
  attr_accessible :name, :description, :price_in_cents, :categories, :category_ids

  has_many :orders
  has_many :product_categories, :dependent => :destroy
  has_many :categories, :through => :product_categories

  monetize :price_in_cents, :target_name => "price"
end
