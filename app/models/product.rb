class Product < ActiveRecord::Base
  before_save :clean_price!

  attr_accessible :description, :price, :title, :photo
  has_many :order_items
  has_many :orders, :through => :order_items
  has_many :product_categories
  has_many :categories, :through => :product_categories
  validates :title, :uniqueness => true,
            :presence => true
  validates :description, :presence => true
  validates :price, 
            :numericality => true,
            :format => {
              :with => /^(\d+|\d+.\d+)$/,
              :message => "must contain digits"
            }
  validates :photo,
            :allow_blank => true,
            :format => {
              :with => URI::regexp(%w(http https)),
              :message => "must be URL"
            }        

  def clean_price!
    price = self.price

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

    self.price = price
  end

  def add_category(category)
    categories << category
  end
end
