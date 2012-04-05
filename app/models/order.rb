class Order < ActiveRecord::Base
  attr_accessible :billing_method_id, :user_id

  has_one :billing_method
  has_many :line_items

  def user
    User.find(self.user_id)
  end

  def amount
    line_items.map(&:subtotal).inject(:+)
  end

end
