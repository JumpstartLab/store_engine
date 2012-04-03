class Product < ActiveRecord::Base
  attr_accessible :description, :price, :title, :photo
  validates_presence_of :description, :title
  validates_uniqueness_of :title
  validates_numericality_of :price
  validates_format_of :price, 
                      :with    => /^(\d+|\d+.\d{2})$/,
                      :message => "must contain digits"
  validates_format_of :photo,
                      :with => URI::regexp(%w(http https)),
                      :message => "must be URL"
end
