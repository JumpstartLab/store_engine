class ShippingInformation < ActiveRecord::Base
  belongs_to :order
  belongs_to :user
  attr_accessible :user_id,
                  :shipping_address_line_1, 
                  :shipping_address_line_2, 
                  :shipping_address_city, 
                  :shipping_address_state, 
                  :shipping_address_zipcode

  validates :shipping_address_line_1, presence: true
  validates :shipping_address_city, presence: true
  validates :shipping_address_state, presence: true
  validates :shipping_address_zipcode, presence: true
end