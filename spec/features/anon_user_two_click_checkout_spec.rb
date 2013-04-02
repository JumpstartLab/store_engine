require 'spec_helper'


describe 'two click checkout process' do
  # after(:each) do
  #   Product.all.clear
  #   User.all.clear
  # end

  # context 'when the user is anonymous' do
  #   it 'the buy now option should redirect to login' do
  #     FactoryGirl.create(:product)
  #     visit '/products/1'
  #     click_button('Buy Now')
  #     expect(current_path).to eq '/login'
  #   end
  # end

  # context 'when the user is logged in' do
  #   before(:each) do
  #     FactoryGirl.create(:user)
  #     FactoryGirl.create(:product)
  #     visit '/login'
  #     fill_in 'sessions_email', with: 'raphael@example.com'
  #     fill_in 'sessions_password', with: 'password'
  #     click_button 'Login'
  #     visit '/products/1'
  #   end

  #   it 'creates a new new user session' do
  #     visit '/'
  #     expect(page).to have_content("Welcome")
  #   end

  #   context 'when the user clicks the buy now button' do
  #     it 'displays a window to enter their payment info' do

  #       within('#buyNowForm') do
  #         find("button.stripe-button-el").click
  #       end

  #       fill_in "number", with: '4242 4242 4242 4242'
  #       fill_in "Expires", with: '02/15'
  #       fill_in "Name on Card", with: 'Money Baags'
  #       fill_in "Card code", with: '333'
  #       click_button "submit"
  #       expect(current_path).to eq account_orders_path
  #     end
  #   end

  #   context "they've entered payment info and click pay" do
  #     context 'when their payment info is good' do
  #       it 'successfully submits their order ' do
  #         pending
  #         #fill out forms, click pay button
  #         #expect to get a message back that payment is good
  #       end
  #     end

  #     context 'when their payment info is bad' do
  #       it 'returns an error message' do
  #         pending
  #         #fill out forms incorrectly, click pay button
  #         #expect to get error message
  #       end
  #     end
  #   end
  # end

end
