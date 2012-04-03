class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price, :categories
  
  validates_presence_of :name, :description
  validates_numericality_of :price_in_cents, :greater_than => 0
  validates_uniqueness_of :name

  has_many :category_products
  has_many :categories, :through => :category_products

  has_many :order_products
  has_many :orders, :through => :order_products

  def price=(dollar)
    self.price_in_dollars = dollar
  end

  def before_save(record)
    record.price_in_cents = Money.parse(record.price_in_dollars).cents
  end

  def price_in_dollars
    Money.new(price_in_cents).format
  end

  private

  def price_in_dollars=(dollar)
    self.price_in_cents = Money.parse(dollar).cents
  end

end