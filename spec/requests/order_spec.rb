require 'spec_helper'

describe "Indivdiaul Order" do
  it "Should be redirected if not logged in" do
    visit "/orders/new"
    page.should have_content "You must login first"
  end

  context "order show page" do
    let!(:user) do
      FactoryGirl.create(:admin, :password => "mike")
    end

    let!(:non_admin_user) do
      FactoryGirl.create(:user, :password => "mike")
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
        FactoryGirl.create(:order, :user => user, :products => products, :status => statuses.first)]
    end

    before(:each) do
      login(user)
      visit "/orders/#{orders.first.id}"
    end

    it "Displays Order Date & Time" do
      page.should have_content(orders.first.created_at.to_formatted_s(:long_ordinal))
    end

    it "Purchasers name & email" do
      page.should have_content(orders.first.user.name)
      page.should have_content(orders.first.user.email)
    end

    it "Accessible at special URL" do
      page.should have_link(orders.first.unique_url)
    end

    it 'navigates to the special url without auth' do
      click_on 'Logout'
      visit "/orders/track?id=#{orders.first.unique_url}"
      page.should have_link(orders.first.unique_url)
    end

    it 'redirects with invalid special url' do
      click_on 'Logout'
      visit '/orders/track?id=1283718247'
      page.should have_content('Invalid Order tracking code')
    end

    it 'my orders' do
      click_on 'My Orders'
      page.should have_content(orders.last.total_price)
    end

    it 'rejects user if not their order' do
      click_on 'Logout'
      login(non_admin_user)
      visit "/orders/#{orders.first.id}"
      page.should have_content('That is not your order')
    end

    it "total price" do
      page.should have_content(orders.first.total_price)
    end

    it "displays when returned timestamp" do
      visit "/orders/#{orders.last.id}"
      click_on '[mark as returned]'
      page.should have_content('Returned At')
    end

    it "displays if cancelled timestamp" do
      click_on '[cancel]'
      page.should have_content('Cancelled At')
    end

    context "Each Product Needs" do
      it "Name with Link" do
        products.each do |p|
          page.should have_content(p.name)
        end
      end

      it "Quantity" do
        orders.each do |o|
          o.order_products.each do |op|
            page.should have_content(op.quantity)
          end
        end
      end
      it "Price" do
        orders.each do |o|
          o.order_products.each do |op|
            page.should have_content(op.price)
          end
        end
      end
      it "Line item subtotal" do
        orders.each do |o|
          o.order_products.each do |op|
            page.should have_content(Money.new(op.total_price_in_cents).format)
          end
        end
      end
      it "Status of the order" do
        page.should have_content(orders.first.status.name.titlecase)
      end

      it "Links to transition to other statuses as explained above" do
        page.should have_link("[cancel]")
      end
    end
  end
end