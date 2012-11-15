class Address < ActiveRecord::Base
  attr_accessible :street, :street_two,
                  :city, :state, :country,
                  :zipcode, :phone_number
  has_many :orders
  belongs_to :user
end
