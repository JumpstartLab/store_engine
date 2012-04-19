class OrderMailer < ActionMailer::Base
  default from: "ha.urbancyclist@gmail.com"


  def send_confirmation(order)
    @order = order
    email_address = order.find_shipping.email_address
    mail :to => email_address, :subject => "Your Recently Placed Order"
  end

end
