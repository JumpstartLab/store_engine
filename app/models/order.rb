class Order < ActiveRecord::Base
  attr_accessible :user_id, :status, :credit_card_id
  attr_accessor :stripe_card_token

  belongs_to :user
  belongs_to :credit_card

  has_many :order_products, :dependent => :destroy
  has_many :products, :through => :order_products
  validates_presence_of :user_id
  has_many :order_statuses

  scope :desc, order("id DESC")

  def mark_as_paid
    #update_attribute(:status, 'paid')
    self.order_statuses.create(:status => 'paid')
  end

  def current_status
    self.order_statuses.last.status
  end

  def charge(cart)
    if credit_card.charge(cart.cart_total_in_cents)
      self.mark_as_paid
      true
    else
      false
    end
  end

  def save_credit_card
    if valid?
      credit_card = CreditCard.new(user)
      credit_card.add_details_from_stripe_card_token(self.stripe_card_token)
      if credit_card.add_user_to_credit_card(user)
        self.update_attributes( :credit_card_id => credit_card.id )
        self.order_statuses.create( :status => 'pending')
      end
    end
  end

  def order_total
    order_products.inject(Money.new(0, "USD")) do |total, order_product|
      total + order_product.price * order_product.quantity
    end
  end

  def self.orders_by_filter(status)
    if status.nil?
      Order.all
    else
      Order.find_all_by_status(status)
    end
  end

  def self.user_by_order_id(id)
    order = Order.find_by_id(id)
    order.user if order
  end
end
