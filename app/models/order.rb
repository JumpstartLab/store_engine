class Order < ActiveRecord::Base
  attr_accessible :user_id
  has_many :order_items, :dependent => :destroy
  belongs_to :user

  def total_price
    order_items.map(&:line_price).inject(:+)
  end
end
