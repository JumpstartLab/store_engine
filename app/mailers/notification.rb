# Sends out an email
class Notification < ActionMailer::Base
  default from: "noreply@store-engine.herokuapp.com"

  def order_email(user, order)
    @user = user
    @order = order
    mail(:to => user.email, :subject => "Order Placed - ##{order.id}")
  end
end
