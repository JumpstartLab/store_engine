module BillingMethodsHelper
  # def protect_against_other_users
  #   if current_user
  #     if @billing_method && @billing_method.user != current_user
  #       redirect_to root_url, notice: "Sorry, we have to protect our customers' privacy"
  #     end
  #   else
  #     if admin?
  #       redirect_to root_url, notice: "Sorry, we have to protect our customers' privacy"
  #     end
  #   end
  #   # if @billing_method && @billing_method.has_user? && current_user != @billing_method.user
  #   #   redirect_to root_url, notice: "Sorry, we have to protect our customers' privacy"
  #   # end
  #   # if @billing_method.nil? && current_order && (current_order.user.nil? || current_user != current_order.user)
  #   #   redirect_to root_url, notice: "Sorry, we have to protect our customers' privacy"
  #   # end
  # end
end

