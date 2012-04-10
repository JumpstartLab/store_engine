require 'forwardable'

class ProductCategory < ActiveRecord::Base
  attr_accessible :category_id, :product_id

  belongs_to :product
  belongs_to :category

  extend Forwardable

  def_delegators :product, :title, :price, :description
end
