#
class ShippingAddress < ActiveRecord::Base
  attr_accessible :city, :email_address, :name, :state, :street, :zipcode

  validates_presence_of :city, :state, :zipcode,
                        :email_address, :street
  validates_length_of :name, :minimum => 2, :maximum => 20,
             allow_nil: true, unless: Proc.new { |u| u.name.blank? }
  validates_length_of :zipcode, :is => 5
  validates_numericality_of :zipcode, only_integer: true
  validates_uniqueness_of :email_address
  validates_format_of :email_address,
  :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/
  validates_format_of :street,
  :with => /^[\da-zA-Z]{1,10}\s[a-zA-Z\d]{1,20}\s[a-zA-Z.]{1,20}/

  belongs_to :user
  has_many :orders

  def self.find_by_order_id(order_id)
    self.find(Order.find(order_id).shipping_address_id)
  end
end
