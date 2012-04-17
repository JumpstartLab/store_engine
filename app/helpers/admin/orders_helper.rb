module Admin::OrdersHelper

  def order_actions_by_status(status, id)
    case status
    when "paid"
      shipped_link(id) + " | " + cancelled_link(id)
    when "shipped"
      returned_link(id)
    when "pending"
      cancelled_link(id)
    when "returned"
      cancelled_link(id)
    else
      "Looks like your work here is done!"
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
