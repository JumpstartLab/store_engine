class OrderProduct < ActiveRecord::Base
  attr_accessible :price, :quantity

  belongs_to :product
  belongs_to :order

  before_save :add_current_price

  def add_current_price
    self.price_in_cents = product.price_in_cents
  end

  def price
    Money.new(price_in_cents.to_i).format
  end

  def total_price_in_cents
    price_in_cents.to_i * quantity
  end

end
