class Product < ActiveRecord::Base
  attr_accessible :description, :name, :photo, :price, :status

  has_many :order_products
  has_many :orders, :through => :order_products

  has_many :cart_products
  has_many :carts, :through => :cart_products

  has_one :discount

  has_many :product_categories
  has_many :categories, :through => :product_categories

  def add_category_by_id(id)
    category = Category.find(id)
    add_category(category)
  end

  def remove_category_by_id(id)
    category = Category.find(id)
    remove_category(category)
  end

  def add_category(category)
    self.categories ||= [ ]
    self.categories << category
    self.categories.uniq
  end

  def remove_category(category)
    self.categories.delete(category)
  end

end
