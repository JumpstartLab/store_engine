class User < ActiveRecord::Base
  attr_accessible :display_name, :email, :name, 
                  :password, :password_confirmation
  has_secure_password
  before_save :create_remember_token

  validates_presence_of :email, :name

  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  has_one :cart
  has_many :orders

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

end
