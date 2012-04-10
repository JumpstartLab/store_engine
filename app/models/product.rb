class Product < ActiveRecord::Base
  attr_accessible :title, :description,
    :price, :photo, :retired

  has_many :category_products
  has_many :categories, :through => :category_products
  
  validates_presence_of :title, :description

  def self.active
    where(:retired => false)
  end

  def active?
    !retired
  end

  # def category
  # end

  # def categories
  #   # Go get the categories for this product
  #   # put the names in a nice form
  #   # give back the nice form of categories
  # end
end
