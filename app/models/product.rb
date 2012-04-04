class Product < ActiveRecord::Base
  attr_accessible :category_id, :description, :price_in_cents, :title

  has_many :orders
  belongs_to :category
  monetize :price_in_cents, :target_name => "price"
end
