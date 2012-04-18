# == Schema Information
#
# Table name: product_categories
#
#  id          :integer         not null, primary key
#  product_id  :integer
#  category_id :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'forwardable'

class ProductCategory < ActiveRecord::Base
  attr_accessible :category_id, :product_id

  belongs_to :product
  belongs_to :category

  extend Forwardable

  def_delegators :product, :title, :price, :description
end
