require 'forwardable'

class OrderItem < ActiveRecord::Base
  attr_accessible :order_id, :product_id, :quantity

  belongs_to :order
  belongs_to :product

  extend Forwardable

  def product
    @product ||= Product.find(product_id)
  end

  def subtotal
    quantity * price
  end

  def_delegators :product, :title, :price, :description, :photo
end
