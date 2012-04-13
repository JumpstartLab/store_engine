class CreditCard < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :transactions
  has_many :orders, :through => :transactions
end
