require 'spec_helper'

describe "Search" do   
  let!(:user) do 
    FactoryGirl.create(:admin, :password => "mike")
  end

  let!(:products) do
    [FactoryGirl.create(:product, :name => 'First Product'), FactoryGirl.create(:product, :name => 'Second Product'),
     FactoryGirl.create(:product), FactoryGirl.create(:product)]
  end

  let!(:statuses) do
    [FactoryGirl.create(:status), 
     FactoryGirl.create(:status, :name => "paid"),
     FactoryGirl.create(:status, :name => "cancelled"),
     FactoryGirl.create(:status, :name => "returned"),
     FactoryGirl.create(:status, :name => "pending")]
  end

  let!(:orders) do
    [FactoryGirl.create(:order, :user => user, :products => products, :status => statuses.last), 
      FactoryGirl.create(:order, :user => user, :products => [products.first], :status => statuses[1])]
  end

  context 'search products' do
    it 'by name' do
      visit '/search?q=first'
      page.should have_content(products.first.name)
      page.should_not have_content(products.last.name)
    end
  end

  context 'advanced search orders' do
    before(:each) do
      login(user)
      visit '/search/new'
    end

    it 'by status' do
      page.select("paid", :from => "advanced_search[status_id]")
      click_on 'Advanced Search'
      page.should have_content(products.first.name)
      page.should_not have_content(products.last.name)
    end

    context 'by order date' do
      it 'equals' do
        page.select("=", :from => "advanced_search[order_date_operator]")
        click_on 'Advanced Search'
        products.each do |product|
          page.should have_content(product.name)
        end
      end

      it 'less than' do
        page.select("<", :from => "advanced_search[order_date_operator]")
        click_on 'Advanced Search'
        products.each do |product|
          page.should_not have_content(product.name)
        end
      end

      it 'greater than' do
        page.select(">", :from => "advanced_search[order_date_operator]")
        click_on 'Advanced Search'
        products.each do |product|
          page.should_not have_content(product.name)
        end
      end

      it 'greater than when order date is lower' do
        page.select("2011", :from => "advanced_search[order_date(1i)]")
        page.select(">", :from => "advanced_search[order_date_operator]")
        click_on 'Advanced Search'
        products.each do |product|
          page.should have_content(product.name)
        end
      end
    end
  
    context 'by total price' do
      it 'equals' do
        page.select("=", :from => "advanced_search[order_total_operator]")
        fill_in "advanced_search[total_price]", :with => orders.first.total_price
        click_on 'Advanced Search'
        page.should have_content(orders.first.total_price)
      end

      it 'less than' do
        page.select("<", :from => "advanced_search[order_total_operator]")
        fill_in "advanced_search[total_price]", :with => orders.first.total_price
        click_on 'Advanced Search'
        page.should_not have_content(orders.first.total_price)
      end

      it 'greater than' do
        page.select(">", :from => "advanced_search[order_total_operator]")
        fill_in "advanced_search[total_price]", :with => orders.first.total_price
        click_on 'Advanced Search'
        page.should_not have_content(orders.first.total_price)
      end
    end

    it 'by email' do
      fill_in "advanced_search[email]", :with => user.email
      click_on 'Advanced Search'
      orders.each do |o|
        page.should have_content(o.total_price)
      end
    end
  end
end