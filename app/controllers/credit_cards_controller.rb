class CreditCardsController < ApplicationController

def new
  @credit_card = CreditCard.new
end

def create
  @cc = CreditCard.new
  @cc.user = current_user
  raise params.inspect
  @cc.add_details_from_stripe_card_token(
    params[:credit_card][:stripe_card_token] )
  redirect_to new_order_path
end

def index
  @credit_cards = current_user.credit_cards
end

end
