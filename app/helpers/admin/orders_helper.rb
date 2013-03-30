module Admin::OrdersHelper
  def next_status(current_status)
    { 'pending' => 'cancel',
      'paid' => 'mark as shipped',
      'shipped' => 'mark as returned'}[current_status]
  end

  def status_count(status)
    count = @statuses[status] || 0
    "#{count} #{status}"
  end
end
