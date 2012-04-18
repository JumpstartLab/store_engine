class Sale < ActiveRecord::Base
  attr_accessible :endtime, :percentage
  has_one :product
  has_one :category
end
