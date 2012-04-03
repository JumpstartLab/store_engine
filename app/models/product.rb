class Product < ActiveRecord::Base
  attr_accessible :title, :description, :activity, :price, :image_link

  validates_presence_of :title
  validates_presence_of  :description
  validates_presence_of :price

  validates_uniqueness_of :title
end