require 'spec_helper'

describe "As an admin viewing an order's detail page" do
  
  let(:user)  { FactoryGirl.create(:user, :email => "a@a.com") }
  let(:product) { FactoryGirl.create(:product)}
  let(:order_product) { FactoryGirl.create(:order_product, :product => product) }
  let(:order) { FactoryGirl.create(:order, 
                :user => user, :order_products => [order_product]) }
  
  context "and I'm not logged in" do
    before(:each) { visit admin_order_path(order) }
    
    it "redirects me to the signin page" do
      page.should have_content("Sign in")
    end
  end

  context "and I'm logged in" do
    let!(:admin) { FactoryGirl.create(:user, :admin => true) }

    before(:each) do
      login_user_post(admin.email, "foobar")
    end

    it "takes me to the order's detail page" do
      visit admin_order_path(order)
      page.should have_content("Order number: #{order.id}")
    end

    context "the order's status is pending" do
      before(:each) { visit admin_order_path(order) }

      it "shows me a link to mark as cancelled" do
        page.should have_link("Mark as cancelled")
      end

      context "and I click the link to mark as cancelled" do
        before(:each) { click_link_or_button('Mark as cancelled')}

        it "updates the order's status to cancelled" do
          page.should have_content('Status: cancelled')
        end
      end
    end

    context "the order's status is shipped" do

      before(:each) do
        order.order_status.update_attribute(:status, 'shipped')
        visit admin_order_path(order)
      end

      it "shows me a link to mark as returned" do
        page.should have_link("Mark as returned")
      end

      context "and I click the link to mark as returned" do
        before(:each) { click_link_or_button('Mark as returned')}

        it "updates the order's status to returned" do
          page.should have_content('Status: returned')
        end
      end

    end

    context "the order's status is paid" do

      before(:each) do
        order.order_status.update_attribute(:status, 'paid')
        visit admin_order_path(order)
      end

      it "shows me a link to mark as shipped" do
        page.should have_link("Mark as shipped")
      end

      context "and I click the link to mark as shipped" do
        before(:each) { click_link_or_button('Mark as shipped')}

        it "updates the order's status to shipped" do
          page.should have_content('Status: shipped')
        end
      end

    end
  end
end