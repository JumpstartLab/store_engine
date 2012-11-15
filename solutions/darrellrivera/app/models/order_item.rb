# == Schema Information
#
# Table name: order_items
#
#  id         :integer         not null, primary key
#  order_id   :integer
#  product_id :integer
#  quantity   :integer         default(1)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

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
