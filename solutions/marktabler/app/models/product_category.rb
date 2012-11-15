class ProductCategory < ActiveRecord::Base
  attr_accessible :product_id, :category_id

  belongs_to :product
  belongs_to :category
end
