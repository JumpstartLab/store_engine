require "open-uri"

class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price,
                  :categories, :avatar, :category_ids, :avatar_from_url
  
  validates_presence_of :name, :description, :price
  validates_numericality_of :price_in_cents, :greater_than => 0
  validates_uniqueness_of :name, :case_sensitive => false

  has_attached_file :avatar, :styles => { 
                                          :medium => "300x300>", 
                                          :thumb => "100x100>" 
                                        }

  has_many :category_products
  has_many :categories, :through => :category_products

  has_many :order_products
  has_many :orders, :through => :order_products

  has_many :product_ratings
  belongs_to :sale

  def name=(old_name)
    write_attribute(:name, old_name.strip)
  end
  def avatar_from_url
    self.avatar
  end
  def avatar_from_url=(url)
    self.avatar = open(url) if not url.start_with?("/")
  end
  
  def price
    self.price_in_dollars
  end

  def price=(dollar)
    self.price_in_dollars = dollar
  end

  def before_save(record)
    record.price_in_cents = Money.parse(record.price_in_dollars).cents
  end

  def category_sale
    best_sale = Sale.new(:percent_off => 0)
    categories.each do |c|
      if c.sale
        best_sale = c.sale if c.sale.percent_off > best_sale.percent_off
      end
    end
    best_sale
  end

  def best_sale
    if category_sale.percent_off > percent_off
      category_sale
    else
      sale  
    end
  end

  def price_in_dollars
    Money.new(price_in_cents.to_i).format
  end

  def destroy
    self.active = 0 
    self.save
  end

  def can_two_click(current_user)
    if current_user && current_user.address && current_user.stripe_id
      true
    else
      false
    end
  end

  def sale_price
    self.price_in_cents * (1 - best_sale.percent) if best_sale
  end 

  def percent_off
    sale.nil? ? 0 : sale.percent_off
  end

  def sale_price_in_cents
    sale_price
  end

  def sale_price_in_dollars
    Money.new(sale_price).format
  end

  private

  def price_in_dollars=(dollar)
    self.price_in_cents = Money.parse(dollar).cents
  end

end