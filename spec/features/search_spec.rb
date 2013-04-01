require 'spec_helper'

describe 'Search' do
  describe 'as a user' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @product = FactoryGirl.create(:product, title: 'Itchy Sweater')
      @product2 = FactoryGirl.create(:product, title: 'Pantalones', description: 'Warm sweatpants')
      @product3 = FactoryGirl.create(:product, title: 'Master Splinter')
      @product4 = FactoryGirl.create(:product, title: 'Munchkin', description: 'Sweaty-sweat', status: 'retired')
    end

    context 'when anonymous from the homepage' do
      it 'filters product title and description by a single criteria' do
        visit root_path
        fill_in 'product-search', with: 'Sweat'
        click_button 'Search'
        expect(page).to have_xpath("//a[@href='#{product_path(@product)}']")
        expect(page).to have_xpath("//a[@href='#{product_path(@product2)}']")
        expect(page).to_not have_xpath("//a[@href='#{product_path(@product3)}']")
        expect(page).to_not have_xpath("//a[@href='#{product_path(@product4)}']")
      end

      it 'input contains the current search after request is made' do
        visit root_path
        fill_in 'product-search', with: 'Sweat'
        click_button 'Search'
        expect(find_field('product-search').value).to eq 'Sweat'
      end
    end

    context 'when logged in' do
      before(:each) do
        visit '/login'
        fill_in 'sessions_email', with: 'raphael@example.com'
        fill_in 'sessions_password', with: 'password'
        click_button 'Login'
      end

      context 'from the Homepage' do
        it 'filters active products by title and description on a single criteria' do
          visit root_path
          fill_in 'product-search', with: 'Sweat'
          click_button 'Search'
          expect(page).to have_xpath("//a[@href='#{product_path(@product)}']")
          expect(page).to have_xpath("//a[@href='#{product_path(@product2)}']")
          expect(page).to_not have_xpath("//a[@href='#{product_path(@product3)}']")
          expect(page).to_not have_xpath("//a[@href='#{product_path(@product4)}']")
        end
      end

      context 'from the Order History account tab' do
        before(:each) do
          @order = FactoryGirl.create(:order, user: @user, status: 'pending')
          @order.order_items = [FactoryGirl.create(:order_item, product: @product)]
          @order2 = FactoryGirl.create(:order, user: @user, status: 'shipped')
          @order2.order_items = [FactoryGirl.create(:order_item, product: @product2), FactoryGirl.create(:order_item, product: @product3)]
        end

        it 'filters orders correctly by item name' do
          visit account_orders_path
          fill_in 'order-search', with: 'Sweat'
          click_button 'Search'
          expect(page).to have_css('tr', count: 2)
          visit account_orders_path
          fill_in 'order-search', with: 'splinter'
          click_button 'Search'
          expect(page).to have_css('tr', count: 1)
        end
      end
    end
  end

  describe 'as an admin' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @admin = FactoryGirl.create(:admin)
      @product = FactoryGirl.create(:product, title: 'Itchy Sweater')
      @product2 = FactoryGirl.create(:product, title: 'Pantalones', description: 'Warm sweatpants')
      @product3 = FactoryGirl.create(:product, title: 'Master Splinter')
      @product4 = FactoryGirl.create(:product, title: 'Munchkin', description: 'Sweaty-sweat', status: 'retired')
      @order = FactoryGirl.create(:order, user: @user, status: 'pending')
      @order.order_items = [FactoryGirl.create(:order_item, product: @product)]
      @order2 = FactoryGirl.create(:order, user: @user, status: 'shipped')
      @order2.order_items = [FactoryGirl.create(:order_item, product: @product2), FactoryGirl.create(:order_item, product: @product3)]
      @order3 = FactoryGirl.create(:order, user: @user, status: 'pending')
      @order3.order_items = [FactoryGirl.create(:order_item, product: @product4)]
      visit login_path
      fill_in 'sessions_email', with: 'logan@gmail.com'
      fill_in 'sessions_password', with: 'password'
      click_button 'Login'
      visit admin_search_path
    end

    context 'from the order admin tab' do
      it 'can query for status, (>,<,=) total price, (>,<,=) date, and purchaser email' do
        select 'shipped', from: 'admin-order-search-status'
        select '>', from: 'admin-order-search-price-symbol'
        fill_in 'admin-order-search-price', with: '100'
        select '=', from: 'admin-order-search-date-symbol'
        fill_in 'admin-order-search-email', with: 'raphael@example.com'
        click_button 'Search Orders'
        save_and_open_page
        expect(page).to have_css('tr', count: 1)
      end
    end
  end
end
