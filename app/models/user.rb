class User < ActiveRecord::Base
  authenticates_with_sorcery!

  attr_accessible :display_name, :email, :full_name, :admin, :password, :password_confirmation
  #before_save :default_values #get this working and put it back in

  validates_confirmation_of :password, message: "passwords did not match", if: :password
  validates_presence_of :password, :on => :create
  validates :full_name, presence: :true
  validates :email, presence: :true, uniqueness: :true
  validates :display_name, length: { in: 2..32 }, allow_blank: :true

  has_many :orders

  def default_values
    self.admin = false
  end

end
