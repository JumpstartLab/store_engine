class Product < ActiveRecord::Base
  attr_accessible :title, :description,
    :price, :photo, :category_id, :retired, :categories

  has_many :categories, :through => :category_products
  
  validates_presence_of :title, :description

  def self.active
    where(:retired => false)
  end

  def active?
    !retired
  end

  def category
  end

  def categories
  end
end
