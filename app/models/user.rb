class User < ActiveRecord::Base
  authenticates_with_sorcery!
  validates_confirmation_of :password, message: "should match confirmation", if: :password
  attr_accessible :display_name, :email, :full_name
  has_many :orders
end
