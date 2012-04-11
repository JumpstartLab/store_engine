class LineItem < ActiveRecord::Base
  attr_accessible :order_id, :price, :product_id, :quantity
  belongs_to :product
  belongs_to :order

  def self.increment_or_create_line_item(params)
    order = Order.find(params[:order_id])
    if order.has_product?(params[:product_id])
      line_item = order.line_items.find_by_product_id(params[:product_id])
      line_item.increment_quantity(params[:quantity])
    else
      line_item = LineItem.create(params)
    end
  end

  def subtotal
    BigDecimal.new(quantity.to_f * price.to_f, 2)
  end

  def clean_price
    BigDecimal.new(price.to_f, 2)
  end

  def increment_quantity(amount)
    self.quantity += amount.to_i
    self.save
    self.quantity
  end
end
