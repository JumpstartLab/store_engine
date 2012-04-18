module RequestHelpers
  module AddBilling
    def add_billing(params)
      select(params[:card_type], from: "Card type")
      fill_in 'Credit card number', :with => params[:credit_card_number]
      select(params[:credit_card_expiration_date], from: "Expiration_date")
      fill_in 'Street', :with => params[:street]
      fill_in 'City', :with => params[:city]
      select(params[:state], from: "State")
      fill_in 'Zipcode', :with => params[:zipcode]
      fill_in 'Name', :with => params[:name]
      click_link_or_button 'Create Billing method'
    end
    def add_non_user_billing(params)
      select(params[:card_type], from: "Card type")
      fill_in 'Credit card number', :with => params[:credit_card_number]
      select(params[:credit_card_expiration_date], from: "Expiration_date")
      fill_in 'Street', :with => params[:street]
      fill_in 'City', :with => params[:city]
      select(params[:state], from: "State")
      fill_in 'Zipcode', :with => params[:zipcode]
      click_link_or_button 'Create Billing method'
    end
  end
end

