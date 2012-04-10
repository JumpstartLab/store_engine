require 'money'

class Product < ActiveRecord::Base
  has_many :product_categories
  has_many :categories, :through => :product_categories
  has_many :cart_items
  attr_accessible :title, :description, :price
  #monetize :price_cents

  def set_categories(category_ids)
    category_ids.uniq!
    categories.clear
    categories << Category.find(category_ids)
  end

  def price
    money = self[:price_cents].to_i
    Money.new(money, "USD")
  end

  def price=(price_string)
    if price_string.include?(".") 
      price_cents = price_string.gsub(".", "").to_i
    else
      price_cents = "#{price_string}00".to_i
    end
    self[:price_cents] = price_cents
  end
end