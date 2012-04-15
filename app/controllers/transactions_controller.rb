class TransactionsController < ApplicationController

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.create(params[:transaction])
    session[:transaction] = @transaction.id
    raise params.inspect
    redirect_to order_summary_path
  end
end