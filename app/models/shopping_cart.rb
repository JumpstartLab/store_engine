class ShoppingCart < ActiveRecord::Base
  belongs_to :user
  has_many :cart_items
  # attr_accessible :title, :body
end
