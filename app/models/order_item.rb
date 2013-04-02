class OrderItem < ActiveRecord::Base
  attr_accessible :product_id, :quantity, :unit_price, :selling_price, :percent_off
  belongs_to :order
  belongs_to :product
  delegate :title, to: :product

  validates :unit_price, presence: :true,
                         format: { with: /^\d+??(?:\.\d{0,2})?$/ },
                         numericality: { greater_than: 0 }

  validates :quantity, presence: :true,
                       numericality: { greater_than: 0, only_integer: true }

  validates :product, presence: true
  validates :order, presence: true
  validates :selling_price, presence: true,
                            format: { with: /^\d+??(?:\.\d{0,2})?$/ }
  validates :percent_off, presence: true,
                          inclusion: { in: 0..100,
                          message: "percent must be between 0-100" }


  def subtotal
    BigDecimal.new(self.selling_price) * BigDecimal.new(self.quantity)
  end

  def total_discount
    (self.unit_price - self.selling_price) * BigDecimal.new(self.quantity)
  end
end
