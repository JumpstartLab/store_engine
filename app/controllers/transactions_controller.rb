class TransactionsController < ApplicationController

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.create
    customer = Stripe::Customer.create(:card => params[:transaction][:stripe_card_token])
    @transaction.save_stripe_customer_id(current_user, customer)
    session[:transaction] = @transaction.id
    redirect_to order_summary_path
  end
end