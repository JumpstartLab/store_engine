class Category < ActiveRecord::Base
  attr_accessible :name

  has_one :discount

  has_many :product_categories
  has_many :products, :through => :product_categories

  validates_uniqueness_of :name
  validates_presence_of :name
end
