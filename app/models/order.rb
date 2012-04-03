class Order < ActiveRecord::Base
  attr_accessible :status, :total_price

  validates :status, :inclusion => { :in => %w(pending cancelled shipped paid)}
  
  def total_price
    # calculate total price from
  end
end
