#
class Category < ActiveRecord::Base
  attr_accessible :name

  has_many :product_categorizations
  has_many :products, :through => :product_categorizations

  validates_presence_of :name

  def to_param
    [id, name.downcase.split(" ")].join("-")
  end

  def image
    products.first.image
  end
end
