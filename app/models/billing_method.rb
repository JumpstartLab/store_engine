class BillingMethod < ActiveRecord::Base
  attr_accessible :city, :credit_card_expiration_date, :credit_card_number, :name, :state, :street, :zipcode

  belongs_to :user
  has_many :orders
end
