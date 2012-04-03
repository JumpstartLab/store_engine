class Order < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :product
  belongs_to :user

  
end
