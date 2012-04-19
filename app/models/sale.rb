class Sale < ActiveRecord::Base
  attr_accessible :endtime, :percentage
  has_one :product
  has_one :category

  validates :percentage, :presence => true,
                         :numericality => {
                         :greater_than => 0,
                         :less_than    => 100
                          }
end
