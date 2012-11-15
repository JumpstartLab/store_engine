module RequestHelpers
  module AddShipping
    def add_shipping(params)
      fill_in 'Email address', :with => params[:email_address]
      fill_in 'Street', :with => params[:street]
      fill_in 'City', :with => params[:city]
      select(params[:state], from: "shipping_address_state")
      fill_in 'Zipcode', :with => params[:zipcode]
      fill_in 'Name', :with => params[:name]
      click_link_or_button 'Create Shipping address'
    end
    def add_non_user_shipping(params)
      fill_in 'Email address', :with => params[:email_address]
      fill_in 'Street', :with => params[:street]
      fill_in 'City', :with => params[:city]
      select(params[:state], from: "shipping_address_state")
      fill_in 'Zipcode', :with => params[:zipcode]
      click_link_or_button 'Create Shipping address'
    end
  end
end

