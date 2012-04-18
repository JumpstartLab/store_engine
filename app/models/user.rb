# An authenticated person on the system
class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :display_name, :phone_number
  attr_protected :permission

  default_scope :conditions => { :active => 1 }
  authenticates_with_sorcery!

  validates_uniqueness_of :email, :case_sensitive => false
  validates_presence_of :name, :email
  validates_presence_of :password, :on => :create
  validates_format_of :phone_number,
                      :with => /\A[0-9]{10}\Z/,
                      :allow_blank => true,
                      :allow_nil => true

  validates_length_of :display_name, :within => 2..32, :allow_blank => true

  has_many :orders
  has_many :products, :through => :orders
  has_many :product_ratings
  has_one :cart
  has_one :address

  def update_address(input)
    self.address = nil
    addr = Address.new(
                        :street => input[:street],
                        :zipcode => input[:zipcode]
                      )
    if addr.save
      self.address = addr
      true
    else
      false
    end
  end

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

  def street
    if address
      address.street
    else
      ""
    end
  end
  def zipcode
    if address
      address.zipcode
    else
      ""
    end
  end

  def text(msg)
    send_text(msg, self.phone_number) if not self.phone_number.blank?
  end

end
