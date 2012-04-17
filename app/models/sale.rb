class Sale < ActiveRecord::Base
  attr_accessible :category, :end_at, :percent_off, :product

  has_many :categories
  has_many :products

  validates_presence_of :percent_off

  def percent
    self.percent_off.to_f / 100
  end

  def display_percent
    "#{percent_off}%"
  end

end