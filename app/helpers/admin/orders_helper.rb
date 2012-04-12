module Admin::OrdersHelper

  def order_actions_by_status(status, id)
    case status
    when "paid"
      link_to "Mark as shipped", 
        admin_orders_mark_shipped_path(id: id), method: :put
    when "shipped"
      link_to "Mark as returned", 
        admin_orders_mark_returned_path(id: id), method: :put
    when "pending"
      link_to "Mark as cancelled", 
        admin_orders_mark_cancelled_path(id: id), method: :put
    else
      "This order's complete!"
    end
  end

end
