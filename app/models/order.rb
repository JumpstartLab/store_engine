class Order < ActiveRecord::Base
  attr_accessible :status
  belongs_to :user
  has_many :order_items

  validates_associated :order_items
end
