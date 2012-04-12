module Admin::DashboardHelper

  def orders_count_by_status(status)
    Order.find_all_by_status(status).count
  end

  def orders_by_filter(status)
    if status.nil
      Order.all
    else
      Order.find_all_by_status(status)
    end
  end

end
