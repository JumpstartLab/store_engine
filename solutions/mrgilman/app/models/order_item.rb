require 'money'
require 'price'

class OrderItem < ActiveRecord::Base
  include StoreEngine::Price

  attr_accessible :product, :price, :quantity
  belongs_to :order
  belongs_to :product
end
