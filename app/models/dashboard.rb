class Dashboard 
  def orders_with_status(status_name)
    Order.joins(:status).where("statuses.name = ?", status_name)
  end

  def total_pending_orders
    orders_with_status(StoreEngine::Status::PENDING).length
  end

  def total_cancelled_orders
    orders_with_status(StoreEngine::Status::CANCELLED).length
  end

  def total_paid_orders
    orders_with_status(StoreEngine::Status::PAID).length
  end

  def total_shipped_orders
    orders_with_status(StoreEngine::Status::SHIPPED).length
  end

  def total_returned_orders
    orders_with_status(StoreEngine::Status::RETURNED).length
  end
end
