class TransactionsController < ApplicationController

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.create(params[:transaction])
    customer = Stripe::Customer.create(:card =>
                                params[:transaction][:stripe_card_token])
    @transaction.save_stripe_customer_id(current_user, customer)
    current_user.transaction = @transaction
    current_user.save
    redirect_to order_summary_path
  end
end
