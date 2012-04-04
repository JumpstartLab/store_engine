class OrderItem < ActiveRecord::Base
  # attr_accessible :title, :body

  has_one :product
  belongs_to :order
end
