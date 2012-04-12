class OrderItem < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :order
end
