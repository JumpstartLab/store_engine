module Admin::OrdersHelper
  def next_status(current_status)
    { 'pending' => 'cancel',
      'paid' => 'mark as shipped',
      'shipped' => 'mark as returned'}[current_status]
  end
end
