class Order < ActiveRecord::Base
  attr_accessible :status, :user, :products

  validates_presence_of :user, :products, :status

  belongs_to :user
  belongs_to :status

  has_many :order_products
  has_many :products, :through => :order_products

<<<<<<< HEAD
  def process_cart(cart)
    self.user = cart.user
    self.status = Status.find_by_name("pending")
    self.products << cart.products
    self.save
  end

=======
  def total_price_in_cents
    order_products.sum { |op| op.total_price_in_cents }
  end

  def total_price
    Money.new(total_price_in_cents).format
  end
>>>>>>> e40d443004d6bc5cdee97174815f4ccb9e8e11c8
end
