class Order < ActiveRecord::Base
  attr_accessible :user_id, :status, :billing_address, :shipping_address

  has_many :order_items, :dependent => :destroy
  belongs_to :user

  validates :user, presence: true
  validates :order_items, presence: true

  def total_price
    order_items.map(&:line_price).inject(:+)
  end

  def cancelled?
    status == "Cancelled"
  end

  def pending?
    status == "Pending"
  end

  def shipped?
    status == "Shipped"
  end

  def cancellable?
    !cancelled? && !shipped?
  end

  def attach_addresses(params)
    update_attributes(shipping_address: params[:shipping_address],
                       billing_address: params[:billing_address])
  end
end
