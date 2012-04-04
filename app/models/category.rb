class Category < ActiveRecord::Base
  attr_accessible :name
  default_scope :conditions => { :active => 1 }

  has_many :category_products
  has_many :products, :through => :category_products

  validates_presence_of :name
end
