class Order < ActiveRecord::Base
  attr_accessible :status, :user, :products, :stripe_card_token, :is_cart
  default_scope :conditions => { :is_cart => 0 }
  validates_presence_of :status
  validates_presence_of :user, :products, :if => :not_a_cart

  before_create :generate_unique_url

  belongs_to :user
  belongs_to :status
  accepts_nested_attributes_for :user
  has_many :order_products
  has_many :products, :through => :order_products

  def not_a_cart
    true if not self.is_a?(Cart)
  end
  def self.process_cart(cart_id)
    Order.find_cart(cart_id)
  end

  def self.find_cart(cart_id)
    Order.unscoped.find(cart_id)
  end

  def total_price_in_cents
    order_products.sum(&:total_price_in_cents)
  end

  def total_price_in_dollars
    Money.new(total_price_in_cents).format
  end

  def stripe_card_token
    
  end

  def total_price
    Money.new(total_price_in_cents).format
  end

  def individual_quantity
    order_products.quantity
  end

  def create_user(token)
    c = Stripe::Customer.create(
          :card => token,
          :description => user.email
        )
    user.stripe_id = c.id
    user.save
  end

  def charge(token)
    create_user(token) if !user.stripe_id
    Stripe::Charge.create(
        :amount => total_price_in_cents,
        :currency => "usd",
        :customer => user.stripe_id
      )
    self.status = Status.find_or_create_by_name("pending")
    self.is_cart = false
    self.save
  end

  def generate_unique_url
    self.unique_url = (0...32).map{65.+(rand(25)).chr}.join
  end

end
