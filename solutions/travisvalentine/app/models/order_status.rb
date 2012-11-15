class OrderStatus < ActiveRecord::Base
  attr_accessible :status
  belongs_to :order
end
