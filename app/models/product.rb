class Product < ActiveRecord::Base
  attr_accessible :category_id, :description, :price_in_cents, :title
end
