class User < ActiveRecord::Base
  after_initialize :create_cart
  authenticates_with_sorcery!

  attr_accessible :email, :password, :password_confirmation,
                  :display_name, :first_name, :last_name

  validates :password,  :presence => true,
                        :confirmation => true,
                        :on => :create,
                        :length => {
                          :in => 4..12,
                          :too_short => "Must be at least 4 characters.",
                          :too_long => "No more than 10 characters."
                        }

  validates_confirmation_of :password, :on => :create

  validates :email,     :presence => true,
                        :uniqueness => true

  #validates :full_name, :presence => true

  validates :display_name, :allow_blank => true,
                      :length => {
                      :in => 2..32,
                      :too_short => "Try a longer name.",
                      :too_long => "Try a shorter name." }

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
