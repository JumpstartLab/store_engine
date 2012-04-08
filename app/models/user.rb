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

  def add_order(order)
    self.orders ||= []
    self.orders << order
  end

  def self.register(params)
    if User.find_by_email(params[:email])
      result = { :user => nil, :status => 'E-mail has already been registered'}
    elsif params[:password].length < 6
      result = { :user => nil, :status => 'Password must have at least 6 characters'}  
    elsif params[:password] != params[:password_confirmation]
      result = { :user => nil, :status => 'Passwords do not match'}
    else
      user = User.create(params)
      result = { :user => user, :status => 'success' }
    end
    result
  end

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

end
