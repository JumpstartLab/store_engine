class Order < ActiveRecord::Base
  attr_accessible :status, :user_id
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :user_id, presence: true

  validates :status, presence: true,
                     inclusion: { in: %w(pending cancelled paid shipped returned),
                                  message: "%{value} is not a valid status" }

  def update_status
    next_status = { 'pending' => 'cancelled',
                    'paid' => 'shipped',
                    'shipped' => 'returned' }
    self.status = next_status[self.status]
    self.save
  end

  def total
    self.order_items.inject(0) do |memo, order_item|
      memo += order_item.subtotal
    end
  end
end
