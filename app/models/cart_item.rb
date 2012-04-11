require 'money'
require 'price'

class CartItem < ActiveRecord::Base
  include StoreEngine::Price 

  attr_accessible :quantity, :price, :product
  belongs_to :shopping_cart
  belongs_to :order
  belongs_to :product
end