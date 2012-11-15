class Product < ActiveRecord::Base
  REGEX = /^https?:\/\/(?:[a-z\-]+\.)+[a-z]{2,6}(?:\/[^\/#?]+)+\.(?:jpg|gif|png|jpeg)$/
  attr_accessible :description, :name, :photo, :price
  before_save :check_for_photo

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
  validates_format_of :photo, with: REGEX, :allow_blank => true

  monetize :price_cents, :target_name => "price"

  def self.active
    where(:retired => false)
  end

  def self.retired
    where(:retired => true)
  end

  def activate
    self.update_attribute(:retired, false)
  end

  def retire
    if self.update_attribute(:retired, true)
      self.cart_products.destroy_all
    end
  end

  def active?
    if self.retired
      false
    else
      true
    end
  end

  def update_categories(ids)
    self.categories.destroy_all
    ids.each { |id| add_category_by_id(id) }
  end

  def add_category_by_id(id)
    category = Category.find(id)
    add_category(category)
  end

  # def remove_category_by_id(id)
  #   category = Category.find(id)
  #   remove_category(category)
  # end

  def add_category(category)
    self.categories ||= [ ]
    self.categories << category unless self.categories.include? category
    self.categories.uniq
  end

  # def remove_category(category)
  #   self.categories.delete(category)
  # end

  private

  def check_for_photo
    if self.photo.blank?
      self.photo = 'http://i.imgur.com/JPby7.jpg'
    end
  end

end
