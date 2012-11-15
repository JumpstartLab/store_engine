class BillingInformation < ActiveRecord::Base
  belongs_to :order
  belongs_to :user
  attr_accessible :user_id,
                  :credit_card_type, 
                  :credit_card_number, 
                  :credit_card_expiration, 
                  :billing_address_line_1, 
                  :billing_address_line_2, 
                  :billing_address_city,
                  :billing_address_state,
                  :billing_address_zipcode

  VALID_DATE_REGEX = /\d{2}\/\d{4}/
  VALID_CREDIT_CARD_REGEX = /\d{4}-\d{4}-\d{4}-\d{4}/
  STATE_LIST = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA",
                "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD",
                "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ",
                "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC",
                "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]

  validates :credit_card_type, presence: true, 
                               length: { maximum: 20 }
  validates :credit_card_number, presence: true, 
                                 format: { with: VALID_CREDIT_CARD_REGEX },
                                 length: { maximum: 20 }
  validates :credit_card_expiration, presence: true,
                                     format: { with: VALID_DATE_REGEX }
  validates :billing_address_line_1, presence: true
  validates :billing_address_city, presence: true
  validates :billing_address_state, presence: true
  validates :billing_address_zipcode, presence: true

end