class CreditCard < ActiveRecord::Base
  attr_accessor :stripe_card_token
  belongs_to :user
  has_many :transactions
  has_many :orders, :through => :transactions
end
