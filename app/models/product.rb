 class Product < ActiveRecord::Base
  has_many :order_items
  belongs_to :category
  
  attr_accessible :title, :description, :price, :photo, :category_id

  validates :title, :presence => true, :uniqueness => true
  validates :description, :presence => true
  validates :price, :numericality => true

end