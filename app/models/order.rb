class Order < ActiveRecord::Base
  attr_accessible :user_id, :status

  validates :status, :presence => true
  validates :user_id, :presence => true

end
