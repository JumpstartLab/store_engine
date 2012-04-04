class Product < ActiveRecord::Base
  attr_accessible :description, :name, :photo, :price, :status

end
