class OrderItem < ActiveRecord::Base
  attr_accessible :product_id, :quantity, :unit_price
  belongs_to :order
  has_one :product

  validates :product, presence: :true
end
