class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :full_name, :billing_address, :shipping_address, 
  :display_name, :email, :password, :password_confirmation
  has_many :orders

  validates_confirmation_of :password
  validates_length_of :display_name, in: 2..32, allow_blank: true
  validates_presence_of :full_name
  validates_format_of :email, with: /^.+@.+\..+$/
  validates_uniqueness_of :email

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

  def screen_name
    display_name ? display_name : email
  end

end
