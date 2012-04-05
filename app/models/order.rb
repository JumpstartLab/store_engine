class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :user
  attr_accessible :user_id, :status


  validates :status, :presence => true
  validates :user_id, :presence => true

  def next_status
    case status 
    when "pending" then "cancelled"
    when "paid" then "shipped"
    when "shipped" then "returned"
    end
  end
end
