class User < ActiveRecord::Base
  has_many :orders
  
  attr_accessible :email, :full_name, :is_admin, :username

  validates :email, :presence => true, :uniqueness => true
  validates :full_name, :presence => true

end
