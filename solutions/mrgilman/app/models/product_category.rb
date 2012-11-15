class ProductCategory < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :product
  belongs_to :category
end
