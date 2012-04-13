class Transaction < ActiveRecord::Base
  belongs_to :order
  belongs_to :credit_card
end
