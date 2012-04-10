class AdvancedSearch < ActiveRecord::Base
  attr_accessible :email, :order_date, :order_total, :status_id, :total_price, :order_date_operator,
                  :order_total_operator

  belongs_to :status

  validates :order_date_operator, :inclusion => { :in => ['', '<', '>', '='] }
  validates :order_total_operator, :inclusion => { :in => ['', '<', '>', '='] }

  def total_price
    Money.new(order_total.to_i).format
  end

  def total_price=(price)
    self.order_total = Money.parse(price).cents
  end

  def find_orders
    orders = Order.scoped
    orders = orders.where(:status_id => self.status_id) if status.present?
    if order_date.present? and order_date_operator.present?
      orders = orders.where("DATE(created_at) > ?", self.order_date) if order_date_operator == '>'
      orders = orders.where("DATE(created_at) < ?", self.order_date) if order_date_operator == '<'
      orders = orders.where("DATE(created_at) == ?", self.order_date) if order_date_operator == '='
    end

    orders = orders.includes(:user).all

    if order_total.present? and order_total_operator.present?
      orders = orders.find_all { |o| o.total_price_in_cents == order_total } if order_total_operator == '='
      orders = orders.find_all { |o| o.total_price_in_cents > order_total } if order_total_operator == '>'
      orders = orders.find_all { |o| o.total_price_in_cents < order_total } if order_total_operator == '<'
    end

    orders = orders.find_all { |o| o.user.email == email } if email.present?
    orders
  end

end
