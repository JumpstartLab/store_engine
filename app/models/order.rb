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

  def attach_addresses(params)
    update_attributes(shipping_address: params[:shipping_address],
                       billing_address: params[:billing_address])
  end
end
