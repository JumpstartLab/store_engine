require 'spec_helper'

describe 'user rates products' do

  before(:each) do
    @product = FactoryGirl.create(:product)
    @user = FactoryGirl.create(:user)
    order = FactoryGirl.create(:order, user_id: @user.id)
    order_item = FactoryGirl.create(:order_item)
    order_item.order_id = order.id
    order_item.product_id = @product.id
  end
  context 'when they have purchased a product' do
    # before(:each) do
    #   visit product_path(@product)
    #   click_button "Add to Cart"
    #   visit cart_path
    #   click_button "Checkout"
    #   fill_in "number", with: '4242 4242 4242 4242'
    #   fill_in "Expires", with: '02/15'
    #   fill_in "Name on Card", with: 'Money Baags'
    #   fill_in "Card code", with: '333'
    #   click_button "submit"
    # end

    it 'they can rate a product' do
      pending
      # visit login_path
      # fill_in 'sessions_email', with: 'raphael@example.com'
      # fill_in 'sessions_password', with: 'password'
      # click_button 'Login'

      # visit product_path(@product)
      # click_button "Add to Cart"
      # visit cart_path
      # click_button "Checkout"
      # fill_in "number", with: '4242 4242 4242 4242'
      # fill_in "Expires", with: '02/15'
      # fill_in "Name on Card", with: 'Money Baags'
      # fill_in "Card code", with: '333'
      # click_button "submit"
      # visit product_path(@product)
      # expect(page).to have_content('Rate It')
    end

    it 'they can edit a rating left within the last 15 minutes' do
      pending
      #log in user
      # visit '/login'
      # fill_in 'sessions_email', with: 'raphael@example.com'
      # fill_in 'sessions_password', with: 'password'
      # click_button 'Login'

      # #got to account ratings page
      # visit account_ratings_path
      # click_button 'Edit'
      # fill_in 'Description', with: "new text goes here"
      # click_button 'Create Rating'
      # expect(current_path).to eq account_ratings_path
      # expect(page).to have_content "updated rating."
    end

  end

  context 'when they have not purchased a product' do
    it 'they cannot rate the product' do
      visit product_path(@product)
      expect(page).to have_content "No Ratings"
    end

    it 'they can view product rating left by others' do
      rating = FactoryGirl.create(:rating, user_id: @user.id, product_id: @product.id)
      visit product_path(@product)
      expect(page).to have_content("Average Rating")
    end
  end
end
