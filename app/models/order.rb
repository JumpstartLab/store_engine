class Order < ActiveRecord::Base
  attr_accessible :status, :user, :shipping_address, :billing_address, :status_updated_at
  belongs_to :status
  has_many :order_items
  has_one :shipping_address
  has_one :billing_address
  belongs_to :user
end
