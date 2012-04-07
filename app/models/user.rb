class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :display_name
  attr_protected :permission

  default_scope :conditions => { :active => 1 }
  authenticates_with_sorcery!

  validates_uniqueness_of :email
  validates_presence_of :name, :email
  validates_presence_of :password, :on => :create

  validates_length_of :display_name, :within => 2..32
  
  has_many :orders
  has_many :products, :through => :orders
  has_many :product_ratings
  has_one :cart

  def admin
    permission == 9
  end

  def user
    permission == 1
  end

  def destroy
    self.active = 0
    self.save
  end

end
