class OrderItem < ActiveRecord::Base
  belongs_to :order
  has_one :product
  attr_accessible :product_id, :quantity, :unit_price

  validates :product, presence: :true
end
