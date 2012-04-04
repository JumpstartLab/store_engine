class Cart < ActiveRecord::Base
  has_many :cart_items, :dependent => :destroy

  def total_price
    cart_items.map(&:line_price).inject(:+)
  end
end
