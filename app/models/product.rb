class Product < ActiveRecord::Base
  acts_as_paranoid

  attr_accessible :name, :description, :categories, :category_ids
  attr_accessible :price_in_cents, :price, as: :admin

  has_many :orders
  has_many :product_categories, :dependent => :destroy
  has_many :categories, :through => :product_categories

  monetize :price_in_cents, :target_name => "price"
end
