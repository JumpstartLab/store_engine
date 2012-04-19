#
class Order < ActiveRecord::Base
  attr_accessible :billing_method_id, :user_id, :status, :shipping_address_id

  validates_presence_of :status

  belongs_to :billing_method
  belongs_to :user
  belongs_to :shipping_address
  has_many :line_items
  has_many :products, through: :line_items

  def date
    created_at.strftime("%B %d at %l:%M %p")
  end

  def pending?
    status == "pending"
  end

  def user
    return nil if self.user_id == nil
    User.find(self.user_id)
  end

  def amount
    line_items.map(&:subtotal).inject(:+)
  end

  def transition
    if status == "pending"
      if billing_method_id && shipping_address_id
        update_attribute(:status, next_transition)
      else
        false
      end
    else
      set_action_time(next_transition)
      update_attribute(:status, next_transition)
    end
  end

  def next_transition
    if status == "pending"
      "paid"
    elsif status == "paid"
      "shipped"
    elsif status == "shipped"
      "returned"
    end
  end

  def set_action_time(transition)
    if transition == "shipped" || transition == "cancelled"
      update_attribute(:action_time, Time.now)
    end
  end

  def user_name
    return "Guest" if user.nil?
    user.display_name
  end

  def user_email_address
    user.email_address
  end

  def guest_email_address
    if shipping_address_id
      find_shipping.email_address
    else
      "no email yet"
    end
  end

  def has_product?(product_id)
    products.include? Product.find(product_id.to_i)
  end

  def has_billing_method?
    billing_method_id ? true : false
  end

  def find_billing
    BillingMethod.find(billing_method_id)
  end

  def credit_card_last_four
    find_billing.credit_card_number.last(4)
  end

  def has_shipping_address?
    shipping_address_id ? true : false
  end

  def find_shipping
    ShippingAddress.find(shipping_address_id)
  end

  def shipping_street
    find_shipping.street
  end

  def add_user(user_id)
    update_attribute(:user_id, user_id)
  end

  def try_to_add_billing_and_shipping(user_id)
    if user.has_billing_method?
      update_attribute(:billing_method_id, user.billing_method_id)
    end
    if user.has_shipping_address?
      update_attribute(:shipping_address_id, user.shipping_address_id)
    end
  end

  def total_items
    line_items.sum(&:quantity)
  end

end
