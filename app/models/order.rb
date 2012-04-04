class Order < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many :order_items
  belongs_to :user
end
