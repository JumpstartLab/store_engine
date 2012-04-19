class ShippingInformation < ActiveRecord::Base
  belongs_to :order
  belongs_to :user
  attr_accessible :shipping_address_line_1, 
                  :shipping_address_line_2, 
                  :shipping_address_city, 
                  :shipping_address_state, 
                  :shipping_address_zipcode
end