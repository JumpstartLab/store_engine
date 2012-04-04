class Order < ActiveRecord::Base
  attr_accessible :status, :total_price

  validates :status, :inclusion => { :in => %w(pending cancelled shipped paid)}

  has_many :order_items
  has_many :products, through: :order_items
  
  def total_price
    # calculate total price from
  end
end
