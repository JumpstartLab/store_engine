#
class BillingMethod < ActiveRecord::Base
  attr_accessible :city, :month, :year, :credit_card_number
  attr_accessible :name, :state, :street, :zipcode, :user_id, :card_type

  validates_presence_of :city, :month, :year,
                        :credit_card_number, :state,
                        :street, :zipcode
  validates_length_of :name, :minimum => 2, :maximum => 20,
             allow_nil: true, unless: Proc.new { |us| us.name.blank? }
  validates_length_of :zipcode, :is => 5
  validates_numericality_of :zipcode, :credit_card_number, :month, :year,
                            only_integer: true
  validates_length_of :credit_card_number, :in => 15..16
  validates_uniqueness_of :credit_card_number
  validates_format_of :street, with: /^[\da-zA-Z]{1,10}\s[a-zA-Z\d]{1,20}\s
                                     [a-zA-Z.]{1,20}/x

  validates_format_of :year, with: /^2[01]\d{2}/
  validates_format_of :month, with: /^0?1?\d/

  belongs_to :user
  has_many :orders

  def self.find_by_order_id(order_id)
    self.find(Order.find(order_id).billing_method_id)
  end

  def has_user?
    user ? true : false
  end
end
