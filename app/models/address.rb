class Address < ActiveRecord::Base
  attr_accessible :city, :state, :street, :zipcode, :user_id
end
