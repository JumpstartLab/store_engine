class Order < ActiveRecord::Base
  attr_accessible :user_id, :status
end
