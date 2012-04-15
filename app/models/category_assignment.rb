class CategoryAssignment < ActiveRecord::Base
  belongs_to :product
  belongs_to :category

  attr_accessible :category_id, :category, :product_id, :product
end
