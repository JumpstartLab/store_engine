class Order < ActiveRecord::Base
  attr_accessible :billing_method_id, :user_id, :status

  validates_presence_of :billing_method_id, :user_id, :status

  belongs_to :billing_method
  has_many :line_items
  has_many :products, through: :line_items

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

  def user_name
    user.display_name
  end

  def user_email_address
    user.email_address
  end

  def has_product?(product_id)
    if products.include? Product.find(product_id.to_i)
      true
    else
      false
    end
  end

end
