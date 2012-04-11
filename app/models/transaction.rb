class Transaction < ActiveRecord::Base
  attr_accessible :credit_card_number, :expiration_month, :expiration_year, :credit_card_verification_number, :cardholder_name

  belongs_to :order
end
