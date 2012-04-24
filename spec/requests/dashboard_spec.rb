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
       FactoryGirl.create(:status, :name => "paid"),
       FactoryGirl.create(:status, :name => "cancelled"),
       FactoryGirl.create(:status, :name => "returned"),
       FactoryGirl.create(:status, :name => "pending")]
    end

    let!(:orders) do
      [FactoryGirl.create(:order, :products => products, :status => statuses.last), 
        FactoryGirl.create(:order, :products => products, :status => statuses.first),
        FactoryGirl.create(:order, :products => products, :status => statuses[1])]
    end

    before(:each) do
      login(user)
      visit dashboard_path
      #click_link 'Dashboard'
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
          page.should have_content orders.first.status.name.titleize
          page.should have_content orders.last.status.name.titleize
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
        page.should have_link 'Pending'
      end

      it 'sorts by pending orders' do
        click_link 'Pending'
        page.should have_content(orders.first.user.name)
      end

      it 'has cancelled' do
        page.should have_link 'Cancelled'
      end

      it 'has paid' do
        page.should have_link 'Paid'
      end

      it 'has shipped' do
        page.should have_link 'Shipped'
      end

      it 'has returned' do
        page.should have_link 'Returned'
      end
    end
    it "The total number of orders by status" do
      within("#shipped") do
        page.should have_content(1)
      end
    end
    it "links to a specific order" do
      click_link orders.first.id.to_s
      page.should have_content "Order details"
    end
  end
end