class Product < ActiveRecord::Base
  attr_accessible :title, :description, :activity,
                  :price, :image_link,
                  :category_ids, :categories

  validates_presence_of :title, :description
  validates_numericality_of :price, :greater_than => 0

  validates_uniqueness_of :title

  has_many :order_items
  has_many :product_categories
  has_many :categories, :through => :product_categories
  has_many :orders, through: :order_items

  def self.find_by(search_term)
    Product.where("upper(title) like ?", "%#{search_term.upcase}%") +
    Category.where("upper(title) like ?",
      search_term.upcase).map {|category| category.products}.flatten
  end


  def self.active
    Product.where(:activity => true)
  end

  def status?
    activity
  end
end