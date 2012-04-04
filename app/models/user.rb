class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :permission, :display_name
  default_scope :conditions => { :active => 1 }
  authenticates_with_sorcery!

  validates_uniqueness_of :email
  validates_presence_of :name, :email
  validates_presence_of :password, :on => :create
  
  has_many :orders
  has_many :products, :through => :orders
  has_many :product_ratings


  def admin
    permission == 9
  end

  def user
    permission == 1
  end

end
