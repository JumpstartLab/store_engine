class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :permission, :display_name
  authenticates_with_sorcery!

  validates_uniqueness_of :email
  validates_presence_of :name, :password, :email
  
  has_many :orders
  has_many :products, :through => :orders
  has_many :product_ratings


  def admin
    if permission == 9 
      true
    else
      false
    end
  end

  def user
    true if permission == 1
  end

end
