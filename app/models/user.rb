class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :orders
  has_one :cart
  
  attr_accessible :email, :password, :password_confirmation, :user_name, :full_name, :admin

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :full_name
end