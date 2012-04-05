class User < ActiveRecord::Base
  attr_accessible :email_address, :full_name, :display_name, :password, :password_confirmation
  has_secure_password

  validates_presence_of :full_name, :email_address
  validates_format_of :email_address, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/
  validates_uniqueness_of :email_address
  validates_length_of :display_name, :minimum => 2, :maximum => 32, allow_nil: true
end
