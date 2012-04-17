class User < ActiveRecord::Base
  attr_accessible :email_address, :full_name, :display_name, :password
  attr_accessible :password_confirmation
  has_one :billing_method
  has_one :shipping_address
  has_many :orders
  has_secure_password

  validates_presence_of :full_name, :email_address
  validates_format_of :full_name, with: /[a-zA-Z]/
  validates_format_of :email_address,
                      :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/
  validates_uniqueness_of :email_address
  validates_length_of :display_name, :minimum => 2, :maximum => 32,
             allow_nil: true, unless: Proc.new { |u| u.display_name.blank? }

  def pending_order
    orders.find_by_status("pending")
  end

  def has_pending_order?
    pending_order ? true : false
  end

  def billing_method_id
    billing_method.id
  end

  def has_billing_method?
    billing_method ? true : false
  end

  def shipping_address_id
    shipping_address.id
  end

  def has_shipping_address?
    shipping_address ? true : false
  end

 def enable_admin_view
  update_attribute(:admin_view, true)
 end

 def disable_admin_view
  update_attribute(:admin_view, false)
 end

end
