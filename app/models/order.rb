# Order placed on the system by a user
class Order < ActiveRecord::Base
  attr_accessible :status, :status_id, :user, :products, :stripe_card_token,
                  :is_cart, :order_products_attributes
  default_scope :conditions => { :is_cart => 0 }
  validates_presence_of :user, :products, :status, :if => :not_a_cart

  before_create :generate_unique_url

  belongs_to :user
  belongs_to :status
  accepts_nested_attributes_for :user
  has_many :order_products
  has_many :products, :through => :order_products
  accepts_nested_attributes_for :order_products, :allow_destroy => true

  def not_a_cart
    true if not self.is_a?(Cart)
  end

  def self.charge_two_click(cart_id)
    order = Order.process_cart(cart_id)
    order.charge if order.user.address && order.user.stripe_id
    order
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

  def total_price_after_sale_in_cents
    order_products.sum(&:total_price_after_sale_in_cents).to_i
  end

  def total_price_after_sale_in_dollars
    Money.new(total_price_after_sale_in_cents).format
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
    customer = Stripe::Customer.create(
          :card => token,
          :description => user.email
        )
    user.stripe_id = customer.id
    user.save
  end

  def charge(token=nil)
    create_user(token) if !user.stripe_id
    Stripe::Charge.create(
        :amount => total_price_after_sale_in_cents,
        :currency => "usd",
        :customer => user.stripe_id
      )
    self.status = Status.find_or_create_by_name("paid")
    self.is_cart = false
    self.save
  end

  def notify_charge
    Notification.order_email(self.user, self).deliver
    self.user.text("Your order has been placed!
       You bought: #{self.products.map(&:name).join(', ')} -
       Total: #{self.total_price_in_dollars}")
  end

  def generate_unique_url
    self.unique_url = (0...32).map{65.+(rand(25)).chr}.join
  end

  def next_status
    next_status = {
                     "pending" => :cancel,
                     "shipped" => :return,
                     "paid"    => :ship
                  }
    if next_status["#{self.status.name}"]
      send(next_status["#{self.status.name}"])
    end
    self.save
  end

  def cancel
    self.status = Status.find_or_create_by_name('cancelled')
    self.cancelled_at = DateTime.now
  end

  def return
    self.status = Status.find_or_create_by_name('returned')
    self.returned_at = DateTime.now
  end

  def ship
    self.status = Status.find_or_create_by_name('shipped')
    self.shipped_at = DateTime.now
  end

end
