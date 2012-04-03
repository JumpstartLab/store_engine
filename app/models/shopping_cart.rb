class ShoppingCart < ActiveRecord::Base
  has_many :order_products
  # attr_accessible :title, :body
end
