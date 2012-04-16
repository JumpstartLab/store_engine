require "open-uri"

class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price,
                  :categories, :avatar, :category_ids
  
  validates_presence_of :name, :description, :price
  validates_numericality_of :price_in_cents, :greater_than => 0
  validates_uniqueness_of :name

  #default_scope :conditions => { :active => 1 }
  has_attached_file :avatar, :styles => { 
                                          :medium => "300x300>", 
                                          :thumb => "100x100>" 
                                        }

  has_many :category_products
  has_many :categories, :through => :category_products

  has_many :order_products
  has_many :orders, :through => :order_products

  has_many :product_ratings

  def avatar_from_url(url)
    self.avatar = open(url)
  end

  def price=(dollar)
    self.price_in_dollars = dollar
  end

  def price
    self.price_in_dollars
  end

  def before_save(record)
    record.price_in_cents = Money.parse(record.price_in_dollars).cents
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

  private

  def price_in_dollars=(dollar)
    self.price_in_cents = Money.parse(dollar).cents
  end

end