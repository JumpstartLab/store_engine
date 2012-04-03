class ShoppingCart < ActiveRecord::Base
  has_many :cart_items
  # attr_accessible :title, :body
end
