class Order < ActiveRecord::Base
  attr_accessible :status, :user, :shipping_address, :billing_address, :status_updated_at
  belongs_to :status
  has_many :order_items
  belongs_to :shipping_address
  belongs_to :billing_address
  belongs_to :user
end
