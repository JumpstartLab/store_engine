class Order < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :cart_items
end
