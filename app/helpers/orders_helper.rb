module OrdersHelper

  def status_upgrade_link(status, order_id)
    case status
    when "cancelled"
      link_to "Mark Pending", order_statuses_path(
           :order_id => order_id,
           :status => "pending"),
           :class => "Up", :method => :post
    when "pending"
      link_to "Mark Paid", order_statuses_path(
           :order_id => order_id,
           :status => "paid"),
           :class => "Up", :method => :post
    when "paid"
      link_to "Mark Shipped", order_statuses_path(
           :order_id => order_id,
           :status => "shipped"),
           :class => "Up", :method => :post
    when "shipped"
      link_to "Mark Returned", order_statuses_path(
           :order_id => order_id,
           :status => "returned"),
           :class => "Up", :method => :post
    when "returned"
    else
      link_to "Mark Pending", order_statuses_path(
           :order_id => order_id,
           :status => "pending"),
           :class => "Up", :method => :post
    end
  end

  def status_downgrade_link(status, order_id)
    case status
    when "cancelled"

    when "pending"
      link_to "Mark Cancelled", order_statuses_path(
           :order_id => order_id,
           :status => "cancelled"),
           :class => "Down", :method => :post
    when "paid"
      link_to "Mark Pending", order_statuses_path(
           :order_id => order_id,
           :status => "pending"),
           :class => "Down", :method => :post
    when "shipped"
      link_to "Mark Paid", order_statuses_path(
           :order_id => order_id,
           :status => "paid"),
           :class => "Down", :method => :post
    when "returned"
      link_to "Mark Shipped", order_statuses_path(
           :order_id => order_id,
           :status => "shipped"),
           :class => "Down", :method => :post
    else
      link_to "Mark Pending", order_statuses_path(
           :order_id => order_id,
           :status => "pending"),
           :class => "Down", :method => :post
    end
  end

end