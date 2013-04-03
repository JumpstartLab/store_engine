module Admin::OrdersHelper
  def next_status(current_status)
    { 'pending' => t('order.status.next.pending'),
      'paid' => t('order.status.next.paid'),
      'shipped' => t('order.status.next.shipped')}[current_status]
  end

  def status_count(status)
    count = @statuses[status] || 0
    "#{count} #{t('order.status.' + status)}"
  end
end
