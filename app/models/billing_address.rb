class BillingAddress < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :company, :line_1, :line_2, 
                  :city, :state, :zipcode,:phone
  belongs_to :user
end
