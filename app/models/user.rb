class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :email, :name, :username, :password, :password_confirmation
  validates_presence_of :name, :email
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_uniqueness_of :email
  validates_length_of :username, :within => 2..32, 
                      :too_long => "pick a shorter name",
                      :too_short => "pick a longer name"
end
