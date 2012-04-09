class BillingMethod < ActiveRecord::Base
  attr_accessible :city, :credit_card_expiration_date, :credit_card_number
  attr_accessible :name, :state, :street, :zipcode, :user_id

  belongs_to :user
  has_many :orders
end
