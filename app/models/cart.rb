class Cart < ActiveRecord::Base
  attr_accessible :user_id

  belongs_to :user
  has_many :products, :through => :cart_products
end
