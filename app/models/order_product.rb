class OrderProduct < ActiveRecord::Base
  attr_accessible :price

  belongs_to :product
  belongs_to :order

  before_save :add_current_price

  def add_current_price
    self.price_in_cents = product.price_in_cents
  end

end
