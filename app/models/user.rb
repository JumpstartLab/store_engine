class User < ActiveRecord::Base
  after_initialize :create_cart 
  authenticates_with_sorcery!
  
  attr_accessible :email, :password, :password_confirmation,
                  :display_name, :first_name, :last_name, :admin, :default_credit_card_id

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  has_many :orders
  has_many :addresses
  has_many :credit_cards
  has_one :cart

  def is_admin?
    admin
  end

  def name
    "#{first_name} #{last_name}"
  end

  def create_cart
    self.build_cart unless self.cart
  end

  def default_credit_card
    if self.default_credit_card_id
      CreditCard.find_by_id(default_credit_card_id)
    else
      nil
    end
  end

  def set_default_credit_card_by_id(id)
    self.default_credit_card_id = id
    save
  end

  def default_billing_address
    if self.default_billing_address_id
      Address.find_by_id(default_billing_address_id)
    else
      nil
    end
  end

  def set_default_billing_address_by_id(id)
    self.default_billing_address_id = id
    save
  end

  def default_shipping_address
    if self.default_shipping_address_id
      Address.find_by_id(default_shipping_address_id)
    else
      nil
    end
  end

  def set_default_shipping_address_by_id(id)
    self.default_shipping_address_id = id
    save
  end
end
