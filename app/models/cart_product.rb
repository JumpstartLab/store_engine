class CartProduct < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product

  def update_quantity(set=nil)
    if set
      self.quantity = set
      self.save
    else
      self.quantity += 1
      self.save
    end
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
