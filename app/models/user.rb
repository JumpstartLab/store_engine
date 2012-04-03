class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :full_name, :billing_address, :shipping_address, 
  :display_name, :email, :password, :password_confirmation
  has_many :orders

  validates_confirmation_of :password
end
