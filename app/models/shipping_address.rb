class ShippingAddress < ActiveRecord::Base
  attr_accessible :city, :email_address, :name, :state, :street, :zipcode

  belongs_to :user

  def self.find_by_order_id(order_id)
    self.find(Order.find(order_id).shipping_address_id)
  end
end
