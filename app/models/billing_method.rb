#
class BillingMethod < ActiveRecord::Base
  attr_accessible :city, :credit_card_expiration_date, :credit_card_number
  attr_accessible :name, :state, :street, :zipcode, :user_id, :card_type

  validates_presence_of :city, :credit_card_expiration_date,
                        :credit_card_number, :state,
                        :street, :zipcode
  validates_length_of :name, :minimum => 2, :maximum => 20,
             allow_nil: true, unless: Proc.new { |u| u.name.blank? }
  validates_length_of :zipcode, :is => 5
  validates_numericality_of :zipcode, :credit_card_number,
                            only_integer: true
  validates_length_of :credit_card_number, :in => 15..16
  validates_uniqueness_of :credit_card_number
  validates_format_of :street, with: /^[\da-zA-Z]{1,10}\s[a-zA-Z\d]{1,20}\s[a-zA-Z.]{1,20}/

  belongs_to :user
  has_many :orders

  def self.find_by_order_id(order_id)
    self.find(Order.find(order_id).billing_method_id)
  end

  def has_user?
    user ? true : false
  end
end
