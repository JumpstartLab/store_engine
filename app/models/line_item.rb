class LineItem < ActiveRecord::Base
  attr_accessible :order_id, :price, :product_id, :quantity
  belongs_to :product
  belongs_to :order

  def subtotal
    BigDecimal.new(quantity.to_f * price.to_f, 2)
  end

  def clean_price
    BigDecimal.new(price.to_f, 2)
  end

end
