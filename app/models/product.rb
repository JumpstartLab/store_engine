class Product < ActiveRecord::Base
  attr_accessible :title, :description, :price, :photo_url
  has_many :product_categorizations
  has_many :categories, :through => :product_categorizations

  validates_presence_of :title, :description, :price
  validates_uniqueness_of :title
  validates_numericality_of :price
  # validates_format_of :photo_url, with: /^https?:\/\/(?:[a-z\-]+\.)+[a-z]{2,6}(?:\/[^\/#?]+)+\.(?:jpg|gif|png|jpeg)$/, allow_nil: true
end
