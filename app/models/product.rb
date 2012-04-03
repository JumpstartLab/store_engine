class Product < ActiveRecord::Base
  attr_accessible :title, :description, :activity, :price, :image_link
end