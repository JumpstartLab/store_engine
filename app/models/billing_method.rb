#
class BillingMethod < ActiveRecord::Base
  attr_accessible :city, :credit_card_expiration_date, :credit_card_number
  attr_accessible :name, :state, :street, :zipcode, :user_id, :card_type

  # validates_presence_of :city, :credit_card_expiration_date
  # validates_presence_of :credit_card_number, :state, :street, :zipcode

  ### VALIDATE FORMAT OF BILLING STUFF

  belongs_to :user
  has_many :orders

  def self.find_by_order_id(order_id)
    self.find(Order.find(order_id).billing_method_id)
  end

  def has_user?
    user ? true : false
  end
end
