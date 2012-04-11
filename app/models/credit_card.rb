class CreditCard < ActiveRecord::Base
  attr_accessible :credit_card_number, :cvc, :expiration_date, :user_id
end
