class User < ActiveRecord::Base
  attr_accessible :email, :name, :username
  validates_presence_of :name, :email
  validates_uniqueness_of :email
  validates_length_of :username, :within => 2..32, 
                      :too_long => "pick a shorter name",
                      :too_short => "pick a longer name"
end
