# == Schema Information
#
# Table name: categories
#
#  id                  :integer         not null, primary key
#  product_category_id :integer
#  name                :string(255)
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#

class Category < ActiveRecord::Base
  attr_accessible :name, :product_category_id
  has_many :product_categories
  has_many :products, :through => :product_categories

  def add_product(product)
    products << product
  end
end
