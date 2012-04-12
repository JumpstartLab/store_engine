class CartProduct < ActiveRecord::Base
  attr_accessible :quantity
  
  belongs_to :cart
  belongs_to :product

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
