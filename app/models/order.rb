class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :user
  attr_accessible :user_id, :status, :total


  validates :status, :presence => true
  validates :user_id, :presence => true

  def next_status
    case status 
    when "pending" then "cancelled"
    when "paid" then "shipped"
    when "shipped" then "returned"
    end
  end

  def total
    order_items.sum('subtotal')
  end

  # def total
  #   total = 0
  #   order_items.each do |oi|
  #     total += oi.subtotal
  #   end
  #   total
  # end

  def status_count
    status_hash = {}
    status_hash["shipped"] = Order.count(:conditions => "status = shipped")
    status_hash["pending"] = Order.count(:conditions => "status = pending")
    status_hash["cancelled"] = Order.count(:conditions => "status = cancelled")
  # # end


end
