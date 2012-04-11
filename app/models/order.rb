class Order < ActiveRecord::Base
  attr_accessible :id

  has_many :order_items
  has_many :products, :through => :order_items

  belongs_to :user
end
