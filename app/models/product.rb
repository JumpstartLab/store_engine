class Product < ActiveRecord::Base
  attr_accessible :title, :description, :activity, :price, :image_link, :categories

  validates_presence_of :title, :description
  validates_numericality_of :price, :greater_than => 0

  validates_uniqueness_of :title

  has_many :order_items
  has_many :product_categories
  has_many :categories, :through => :product_categories
  has_many :orders, through: :order_items
end