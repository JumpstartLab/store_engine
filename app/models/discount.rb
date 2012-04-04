class Discount < ActiveRecord::Base
  attr_accessible :category_id, :percentage, :product_id

  belongs_to :product
  belongs_to :category
end
