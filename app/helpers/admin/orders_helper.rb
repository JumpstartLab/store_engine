module Admin::OrdersHelper

  def order_actions_by_status(status, id)
    case status
    when "paid"
      shipped_link(id) + " | " + cancelled_link(id)
    when "shipped"
      returned_link(id)
    when "pending"
      link_to "Mark as cancelled", 
        admin_orders_mark_cancelled_path(id: id), method: :put
    when "returned"
      cancelled_link(id)
    else
      "Looks like your work here is done!"
    end
  end

  def shipped_link(id)
    link_to("Mark as shipped", 
        admin_orders_mark_shipped_path(id: id), method: :put)
  end

  def returned_link(id)
    link_to("Mark as returned", 
        admin_orders_mark_returned_path(id: id), method: :put)
  end

  def cancelled_link(id)
    link_to("Mark as cancelled", 
        admin_orders_mark_cancelled_path(id: id), method: :put)
  end

end
