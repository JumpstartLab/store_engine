class Order < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user

  has_many :order_products
  has_many :products, :through => :order_products

  
end
