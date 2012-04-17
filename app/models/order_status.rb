class OrderStatus < ActiveRecord::Base
  attr_accessible :status, :order_id

  belongs_to :order

  # def initialize(order_id)
  #   @order = Order.find(order_id)
  # end

  def update_status(action)
    case action
    when 'paid'
      self.update_attributes(:status => 'paid')
    when 'cancelled'
      self.update_attributes(:status => 'cancelled')
    when 'shipped'
      self.update_attributes(:status => 'shipped')
    when 'returned'
      self.update_attributes(:status => 'returned')
    end
  end

end
