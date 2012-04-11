class BillingMethod < ActiveRecord::Base
  attr_accessible :city, :credit_card_expiration_date, :credit_card_number
  attr_accessible :name, :state, :street, :zipcode, :user_id

  # validates_presence_of :city, :credit_card_expiration_date
  # validates_presence_of :credit_card_number, :state, :street, :zipcode

  ### VALIDATE FORMAT OF BILLING STUFF

  belongs_to :user
  has_many :orders
end
