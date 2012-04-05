class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :username, :display_name, :email, :password, 
    :password_confirmation, :admin

  validates_length_of :password, :minimum => 3, :message => "password must be at least 3 characters long", :if => :password
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password

  has_one :shopping_cart
end
