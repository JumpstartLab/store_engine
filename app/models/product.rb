class Product < ActiveRecord::Base
  attr_accessible :title, :description, :price, :photo_url, :category_id
end
