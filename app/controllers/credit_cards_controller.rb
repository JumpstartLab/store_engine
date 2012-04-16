class CreditCardsController < ApplicationController

def new
  @credit_card = CreditCard.new(current_user)
end

def create
  @cc = CreditCard.new(current_user)
  @cc.stripe_create_from_stripe_card_token( params[:credit_card][:stripe_card_token] )
end

end
