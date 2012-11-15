# connects orders with products
class OrderProduct < ActiveRecord::Base
  attr_accessible :price_in_cents, :quantity, :product, :order

  #validates_presence_of :order
  validates_presence_of :product
  validates_numericality_of :quantity, :greater_than => 0

  belongs_to :product
  belongs_to :order

  before_save :add_current_price

  def add_current_price
   self.percent_off = product.best_sale.percent_off if product.best_sale
   self.price_in_cents = product.price_in_cents
  end

  def price
    Money.new(total_price_in_cents).format
  end

  def sale_price
    Money.new(price_in_cents * percent).format
  end

  def total_price_in_cents
    price_in_cents.to_i * quantity
  end

  def total_price_in_dollars
    Money.new(total_price_in_cents).format
  end

  def total_price_after_sale_in_cents
    ((price_in_cents * percent) * quantity)
  end

  def total_price_after_sale_in_dollars
    Money.new(total_price_after_sale_in_cents).format
  end

  def update_quantity(set=nil)
    if set
      self.quantity = set
    else
      self.quantity += 1
      self.save
    end
    self
  end

  def percent
    (1 - (self.percent_off / 100.00)).round(2)
  end

  ## Methods associated with Products
  def name
    product.name
  end

  def total_for_product
    quantity * price_in_cents
  end

end
