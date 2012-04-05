require 'spec_helper'

describe "Dashboard" do

  context 'orders' do
    let!(:user) do
      FactoryGirl.create(:admin, :password => "mike")
    end

    let!(:products) do
      [FactoryGirl.create(:product), FactoryGirl.create(:product)]
    end

    let!(:statuses) do
      [FactoryGirl.create(:status), 
       FactoryGirl.create(:status, :name => "pending")]
    end

    let!(:orders) do
      [FactoryGirl.create(:order, :products => products, :status => statuses.last), 
        FactoryGirl.create(:order, :products => products, :status => statuses.first)]
    end

    before(:each) do
     visit '/login'
     fill_in 'user[email]', :with => user.email
     fill_in 'user[password]', :with => "mike"
     click_button("Sign In")

     visit dashboard_path
     click_link 'Dashboard'
     click_link 'Orders'
    end

    it 'has 2 orders' do
      within(".table") do
        orders.each do |order|
          page.should have_content(order.user.name)
          page.should have_content(order.status.name)
          page.should have_content(order.products.map(&:name).join(', '))
        end
      end
    end

    context 'displays orders by status' do
      it 'has the orders by status title' do
        page.should have_content 'Orders by Status'
      end

      it 'has orders of different status' do
        within("#orders_by_status") do
          page.should have_content orders.first.status.name
          page.should have_content orders.last.status.name
          page.should have_content "1"
        end
      end
    end

    it 'has links for individual orders' do
      page.should have_link orders.first.id.to_s
      click_link orders.first.id.to_s
    end

    context 'has filter links' do
      it 'has pending' do
        page.should have_link 'pending'
      end

      it 'has cancelled' do
        page.should have_link 'cancelled'
      end

      it 'has paid' do
        page.should have_link 'paid'
      end

      it 'has shipped' do
        page.should have_link 'shipped'
      end

      it 'has returned' do
        page.should have_link 'returned'
      end
    end

  end

  it "Displays a lot of dashboard related things" do
    pending
  end
  it "The total number of orders by status" do
    pending
  end
  it "links for each individual order" do
    pending
  end
  it "filters orders to display by status type" do
    pending
  end

end