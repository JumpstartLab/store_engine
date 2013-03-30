require 'spec_helper'

describe 'user account detail view' do
  context 'when the user is logged in' do
    before(:each) do
      #Log in User
      @user = FactoryGirl.create(:user)
      visit '/login'
      fill_in 'sessions_email', with: 'raphael@example.com'
      fill_in 'sessions_password', with: 'password'
      click_button 'Login'
    end

    it 'display the main page of their account details' do
      visit 'account'
      expect(page).to have_content("Account")
    end

    context 'when they click the link to their order history page' do
      it 'takes them to their order history page' do
        visit 'account/'
        click_link "Order History"
        expect(page).to have_content("Order Status")
      end
    end

    context 'when they click on a specific order link' do
      it 'takes them to a view of their specific order' do
        order = FactoryGirl.create(:order, user: @user)
        visit 'account/orders'
        click_link "Order #{order.id}"
        expect(page).to have_content("Quantity")
      end
    end
  end
end
