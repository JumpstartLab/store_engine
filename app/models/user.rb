class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :email, :name, :username, :password, :password_confirmation

  has_one :cart
  has_one :address

  validates_presence_of :name, :email
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_uniqueness_of :email
  validates_length_of :username, :within => 2..32,
                      :too_long => "pick a shorter name",
                      :too_short => "pick a longer name",
                      :allow_nil => true

  def admin?
    role == 'admin'
  end

  def set_role(role)
    self.role = role
    save
    self
  end

  def add_credit_card(cc)
    cc[:user_id] = id
    CreditCard.create(cc)
  end

  def add_address(address)
    address[:user_id] = id
    Address.create(address)
  end
end
