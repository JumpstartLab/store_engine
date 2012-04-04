class User < ActiveRecord::Base
  attr_accessible :display_name, :email, :name, 
                  :password, :password_confirmation
  has_secure_password

  validates_presence_of :email, :name

  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
end
