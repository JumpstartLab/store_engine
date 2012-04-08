class Order < ActiveRecord::Base
  attr_accessible :billing_method_id, :user_id, :status

  validates_presence_of :billing_method_id, :user_id, :status

  belongs_to :billing_method
  has_many :line_items

  def user
    User.find(user_id)
  end

  def amount
    line_items.map(&:subtotal).inject(:+)
  end

  def next_transition
    if status == "pending"
      "paid"
    elsif status == "paid"
      "shipped"
    else
      "pending"
    end
  end

end
