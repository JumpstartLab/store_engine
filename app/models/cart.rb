class Cart < ActiveRecord::Base
  has_many :cart_items
  has_many :product, :through => :cart_items

end
