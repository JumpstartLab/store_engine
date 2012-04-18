class Order < ActiveRecord::Base
  STATUSES = ["pending", "cancelled", "paid", "shipped", "returned"]
  attr_accessible :user_id, :status, :billing_address, :shipping_address
  attr_accessible :credit_card, :email_address


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

    define_method(status + "=") do |status|
      status = status.downcase if status
      write_attribute(:status, status)
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
        # TODO:
        # What's the best way to do this?
        # This destroys the items immediately;
        # I only want to destroy them when save is called,
        # conditioned on wheather the order has no errors.
        # However, it's also invalid for an OrderItem to have quantity of 0...
        # So the save would never happen, so I can't use an after-save hook...
        item.destroy
      end
    end
  end
end
