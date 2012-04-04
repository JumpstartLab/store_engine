class Order < ActiveRecord::Base
  attr_accessible :billing_method_id, :user_id

  has_one :billing_method
  has_many :line_items

  def user_name
    User.find(self.user_id).full_name
  end

  def amount
    line_items.map{|li| li.price * li.quantity}.inject(:+)
  end
end
