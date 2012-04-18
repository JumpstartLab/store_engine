module BillingMethodsHelper
  def validate_billing_user
    if @billing_method.user_id.nil?
      if Order.find_by_billing_method_id(@billing_method.id) != current_order
        redirect_to root_url, notice: "Sorry, you are not allowed to view that."
        false
      else true
      end
    else
      if @billing_method.user_id != current_user.id
        redirect_to root_url, notice: "Sorry, you are not allowed to view that."
        false
      else true
      end
    end
  end
end
