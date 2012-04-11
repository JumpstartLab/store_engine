class Order < ActiveRecord::Base
  STATUSES = ["pending", "cancelled", "paid", "shipped", "returned"]
  attr_accessible :user_id, :status, :billing_address, :shipping_address

  has_many :order_items, :dependent => :destroy
  has_many :items, through: :order_items
  belongs_to :user

  validates :user, presence: true
  #validates :order_items, presence: true
  validates :status, inclusion: { in: STATUSES }

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

  def cancelled?
    status == "cancelled"
  end

  def pending?
    status == "pending"
  end

  def shipped?
    status == "shipped"
  end

  def cancellable?
    !cancelled? && !shipped?
  end

  def attach_addresses(params)
    update_attributes(shipping_address: params[:shipping_address],
                       billing_address: params[:billing_address])
  end
end
