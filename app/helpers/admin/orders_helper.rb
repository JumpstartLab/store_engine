module Admin::OrdersHelper

  def order_actions_by_status(order)
    case order.status
    when "paid"
      shipped_link(order.id) + " | " + cancelled_link(order.id)
    when "shipped"
      returned_link(order.id)
    when "pending"
      cancelled_link(order.id)
    when "returned"
      "Returned"
    when "cancelled"
      "Cancelled."
    end
  end

  def timestamp(order)
    case order.status
    when 'shipped', 'cancelled'
      "#{order.status.capitalize} on #{order.updated_at.to_s(:pretty)}"
    end
  end

  def shipped_link(id)
    link_to("Mark as shipped", 
        admin_order_status_path(order_id: id, new_status: 'shipped'),
        method: :put)
  end

  def returned_link(id)
    link_to("Mark as returned", 
        admin_order_status_path(order_id: id, new_status: 'returned'),
        method: :put)
  end

  def cancelled_link(id)
    link_to("Mark as cancelled", 
        admin_order_status_path(order_id: id, new_status: 'cancelled'),
        method: :put)
  end

end
