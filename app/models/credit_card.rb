class CreditCard < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  has_many :transactions
  has_many :orders, :through => :transactions
end
