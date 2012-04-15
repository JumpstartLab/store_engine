class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :username, :display_name, :email, :password, 
    :password_confirmation, :admin

  validates_length_of :password, :minimum => 3, :message => "password must be at least 3 characters long", :if => :password
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password

  has_one :shopping_cart
  has_many :orders
  has_many :shipping_addresses
  has_many :billing_addresses

  def cart?
    if shopping_cart.nil?
      false
    else
      true
    end
  end
  
  def admin?
    admin
  end
end
