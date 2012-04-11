class Product < ActiveRecord::Base
  attr_accessible :title, :description, :price, :photo, :retired, :category_ids

  has_many :category_products
  has_many :categories, :through => :category_products
  
  validates_presence_of :title, :description

  has_many :order_items

  def self.active
    where(:retired => false)
  end

  def active?
    !retired
  end

end
