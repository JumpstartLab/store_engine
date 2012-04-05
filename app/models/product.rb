class Product < ActiveRecord::Base
  attr_accessible :description, :price, :title, :photo
  before_save :clean_price
  validates_presence_of :description, :title
  validates_uniqueness_of :title
  validates_numericality_of :price
  validates_format_of :price, 
                      :with    => /^(\d+|\d+.\d+)$/,
                      :message => "must contain digits"
  validates_format_of :photo,
                      :with => URI::regexp(%w(http https)),
                      :message => "must be URL"
  has_many :order_items
  has_many :orders, :through => :order_items

  def clean_price
    price = price.to_s
    if price.include?(".")
      cents = price.split(".").last
      dollars = price.split(".").first
      if cents.length == 1
        cents = cents + "0"
      else
        cents = cents[0..1]
      end
      price = "#{dollars}.#{cents}"
    else
      price = price + ".00"
    end
  end
end
