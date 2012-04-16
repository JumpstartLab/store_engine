class CreditCardsController < ApplicationController

def new
  @credit_card = CreditCard.new
end

def create
  @credit_card = CreditCard.create(params[:credit_card])
end

end
