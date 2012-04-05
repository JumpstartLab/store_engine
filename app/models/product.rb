class Product < ActiveRecord::Base
  attr_accessible :title, :description, :price, :image, :remote_image_url
  has_many :orders
  
  has_many :product_categories
  has_many :categories, :through => :product_categories

  mount_uploader :image, ImageUploader

end