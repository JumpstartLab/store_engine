class Order < ActiveRecord::Base
  attr_accessible :status, :user, :products

  validates_presence_of :user, :products, :status

  belongs_to :user
  belongs_to :status

  has_many :order_products
  has_many :products, :through => :order_products

  def process_cart(cart)
    self.user = cart.user
    self.status = Status.find_by_name("pending")
    self.products << cart.products
    self.save
  end

end
