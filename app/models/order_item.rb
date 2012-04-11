class OrderItem < ActiveRecord::Base
  attr_accessible :order_id, :product_id, :quantity

  belongs_to :order
  belongs_to :product

  validates :order, :product_id, presence: true
  validates :quantity, numericality: { greater_than: 0 }
  validate :changed_fields_only_when_pending

  def line_price
    each_price * quantity
  end

  def each_price
    product.price
  end

  private

  # TODO: Probably shouldn't be able to delete either.
  #       before_destroy hook, perhaps?
  def changed_fields_only_when_pending
    return if order.pending?

    if changed?
      errors << "Can't change order item unless order is pending"
    end
  end
end
