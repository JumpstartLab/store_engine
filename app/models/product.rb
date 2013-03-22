class Product < ActiveRecord::Base
  belongs_to :category
  attr_accessible :description, :price, :status, :title
end
