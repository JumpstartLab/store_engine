class User < ActiveRecord::Base
  attr_accessible :display_name, :email, :name, 
                  :password, :password_confirmation
  has_secure_password
  before_save :create_remember_token

  validates_presence_of :email, :name, :password, :password_confirmation

  validates :password, length: { minimum: 6 }, :presence => { :message => 'must be at least 6 characters.' }
  validate :password_match, :on => :create
  validates_uniqueness_of :email

  has_one :cart
  has_many :orders

  def password_match
    if !self.password == self.password_confirmation
      errors.add(:password, 'Passwords do not match')
    end
  end

  def add_order(order)
    self.orders ||= []
    self.orders << order
  end

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

end
