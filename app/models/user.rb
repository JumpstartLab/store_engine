class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :full_name, :billing_address, :shipping_address, :display_name, :email
  has_many :orders
end
