class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :full_name, :billing_address, :shipping_address, 
  :display_name, :email, :password, :password_confirmation
  has_many :orders

  validates_confirmation_of :password

  def admin?
    admin
  end

  def update_addresses(params)
    if shipping_address != params[:shipping_address]
      update_attributes(shipping_address: params[:shipping_address])
    end
    if billing_address != params[:billing_address]
      update_attributes(billing_address: params[:billing_address])
    end
  end

end
