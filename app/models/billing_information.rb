class BillingInformation < ActiveRecord::Base
  belongs_to :order
  belongs_to :user
  attr_accessible :credit_card_type, 
                  :credit_card_number, 
                  :credit_card_expiration, 
                  :billing_address_line_1, 
                  :billing_address_line_2, 
                  :billing_address_city,
                  :billing_address_state,
                  :billing_address_zipcode
end
