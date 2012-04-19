class ShippingDetail < ActiveRecord::Base
  attr_accessible :ship_to_name, :ship_to_address_1, :ship_to_address_2,
    :ship_to_city, :ship_to_state, :ship_to_country, :ship_to_zip,
    :default_shipping_address

  validates_presence_of :user_id

  has_many :orders, :through => :order_shipping_details
  belongs_to :user
  before_save :set_to_default


  def set_to_default
    user = User.find(self.user_id)
    unless user.shipping_details.find_by_default_shipping_address(true)
      self.default_shipping_address = true
    end
  end

end
