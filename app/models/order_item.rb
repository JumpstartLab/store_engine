class OrderItem < ActiveRecord::Base
  attr_accessible :product_id, :quantity, :unit_price
  belongs_to :order
  belongs_to :product
  # has_one ? (using through on the other side)

  validates :unit_price, presence: :true,
                         format: { with: /^\d+??(?:\.\d{0,2})?$/ },
                         numericality: { greater_than: 0 }
  validates :quantity, presence: :true,
                       numericality: { greater_than: 0, only_integer: true }
  validates :product, presence: :true

  def subtotal
    self.unit_price * self.quantity
  end

  def title
    product.title
  end

end
