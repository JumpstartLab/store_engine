class Product < ActiveRecord::Base
  attr_accessible :description, :name, :photo, :price

  has_many :order_products
  has_many :orders, :through => :order_products

  has_many :cart_products
  has_many :carts, :through => :cart_products

  has_one :discount

  has_many :product_categories
  has_many :categories, :through => :product_categories

  validates_presence_of :name, :description, :price
  validates_uniqueness_of :name
  validates_numericality_of :price, :greater_than => 0

  monetize :price_cents, :target_name => "price"

  def self.active
    where(:retired => false)
  end

  def retire
    self.retired = true
    save
  end

  def update_categories(ids)
    deleted = self.category_ids - ids
    added = ids - self.category_ids

    deleted.each do |id|
      remove_category_by_id(id)
    end

    added.each do |id|
      add_category_by_id(id)
    end
  end

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
