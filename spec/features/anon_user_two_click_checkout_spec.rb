require 'spec_helper'


describe 'two click checkout process' do
  after(:each) do
    Product.all.clear
    User.all.clear
  end

  context 'when the user is anonymous' do
    it 'the buy now option should redirect to login' do
      FactoryGirl.create(:product)
      visit '/products/1'
      click_button('Buy Now')
      expect(current_path).to eq '/login'
    end
  end

  context 'when the user is logged in' do
    xit 'the buy now option should be present' do
      FactoryGirl.create(:user)
      FactoryGirl.create(:product)
      visit '/login'
      fill_in 'sessions_email', with: 'raphael@example.com'
      fill_in 'sessions_password', with: 'password'
      click_button 'Login'
      visit '/products/1'
      page.should have_xpath("//button[@class='stripe-button-el']")
    end
  end
end
