class OrderProduct < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  def title
    product.title
  end

end
