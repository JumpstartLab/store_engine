class OrderProduct < ActiveRecord::Base
  attr_accessible :price_in_cents, :quantity, :product, :order

  #validates_presence_of :order
  validates_presence_of :product

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
  validates_numericality_of :quantity, :greater_than => 0

  def update_quantity(set=nil)
    if set
      self.quantity = set
    else
      self.quantity += 1
      self.save      
    end
    self
  end
  ## Methods associated with Products
  def name
    product.name
  end

  def price
    product.price
  end

  def price_in_cents
    product.price_in_cents
  end

  def total_for_product
    quantity * price_in_cents
  end
  
end
