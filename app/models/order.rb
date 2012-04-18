class Order < ActiveRecord::Base
  STATUSES = ["pending", "cancelled", "paid", "shipped", "returned"]
  DEFAULT_STATUS = "pending"
  attr_accessible :user_id, :status, :billing_address, :shipping_address, :credit_card, :email_address

  has_many :order_items, :dependent => :destroy, :autosave => true
  has_many :items, through: :order_items
  belongs_to :user
  validates_presence_of :billing_address
  validates_presence_of :email_address
  validates_presence_of :credit_card

  after_save :assume_shipping_address

  #validates :user, presence: true
  #validates :order_items, presence: true
  validates :status, inclusion: { in: STATUSES }

  def self.build_with_user(params, user)
    params.merge!(status: DEFAULT_STATUS)
    order = self.new(params)
    order.user = user if user
    return order
  end

  def add_items_from_cart!(cart)
    cart.cart_items.each do |cart_item|
      self.order_items.create!(product_id: cart_item.product_id,
                         quantity: cart_item.quantity)
    end
    cart.destroy
  end

  def assume_shipping_address
    if shipping_address.blank?
      update_attribute(:shipping_address, billing_address)
    end
  end

  def self.count_by_status(status)
    self.where(status: status).count
  end

  def self.count_report
    result = {}
    STATUSES.each do |status|
      result[status.to_sym] = self.count_by_status(status)
    end
    result
  end

  def total_price
    order_items.map(&:line_price).inject(:+)
  end

  def status=(val)
    val = val.downcase if status
    write_attribute(:status, val)
  end

  STATUSES.each do |status|
    define_method(status + "?") do
      self.status == status
    end
  end

  def cancellable?
    !cancelled? && !shipped?
  end

  def set_quantities(quantities)
    quantities.each do |id, quantity|
      quantity = quantity.to_i
      item     = order_items.find(id)
      if quantity > 0
        item.update_attribute(:quantity, quantity)
      else
        item.destroy
      end
    end
  end
end
