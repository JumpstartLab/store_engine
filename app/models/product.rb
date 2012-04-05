 class Product < ActiveRecord::Base
  has_many :order_items
  
  attr_accessible :title, :description, :price, :photo

  validates :title, :presence => true, :uniqueness => true
  validates :description, :presence => true
  validates :price, :numericality => true

end