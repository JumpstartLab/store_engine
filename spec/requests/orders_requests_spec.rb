require 'spec_helper'

describe "For orders" do
  context "when logged in as a standard user" do
    let!(:user) { Fabricate(:user, email: "foozberry@example.com") }

    before(:each) do
      visit signin_path
      fill_in "Email",        with: user.email
      fill_in "Password",     with: user.password
      click_button "Sign in"
    end
  
    context "#index" do
      let!(:orders) { [Fabricate(:order, :user_id => user.id), Fabricate(:order, :user_id => user.id)] }

      before(:each) do
        visit orders_path
      end

      it "has an area that list the orders" do
        page.should have_selector("table#orders")
      end

      it "lists orders in the system" do
        within("table#orders") do
          orders.each do |order|
            page.should have_content(order.id)
          end
        end
      end

      it "lists the status of the orders in its list" do
        within("table#orders") do
          orders.each do |order|
            page.should have_content(order.status)
          end
        end
      end

      it "has a place to sort by status" do
        page.should have_selector("#status_sort")
      end

      it "allows the user to sort by status" do
        pending "Not sure how to set up the selecting on the page itself"
      end

      context "can filter orders by their status" do

        it "lists pending orders" do
          page.should have_selector("#pending_orders")
        end

        it "lists cancelled orders" do
          page.should have_selector("#cancelled_orders")
        end
        
        it "lists paid orders" do
          page.should have_selector("#paid_orders")
        end
        
        it "lists shipped orders" do
          page.should have_selector("#shipped_orders")
        end
        
        it "lists returned orders" do
          page.should have_selector("#returned_orders")
        end
      end

      context "listing total number of products by status" do
        it "has an area to list # of orders by status" do
          page.should have_selector("#status_count")
        end
        it "includes total # of orders" do
          within ("#status_count") do
            page.should have_content(Order.all.count)
          end
        end
        it "lists number of pending orders" do
          within ("#status_count") do
            page.should have_content(Order.find_all_by_status("pending").count)
          end
        end

        it "lists number of cancelled orders" do
          within ("#status_count") do
            page.should have_content(Order.find_all_by_status("cancelled").count)
          end
        end

        it "lists number of paid orders" do
          within ("#status_count") do
            page.should have_content(Order.find_all_by_status("paid").count)
          end
        end

        it "lists number of shipped orders" do
          within ("#status_count") do
            page.should have_content(Order.find_all_by_status("shipped").count)
          end
        end

        it "lists number of returned orders" do
          within ("#status_count") do
            page.should have_content(Order.find_all_by_status("returned").count)
          end
        end

      end
    end

    context "#show" do
      let!(:order) { Fabricate(:order, :user_id => user.id) }
      let!(:products) { [Fabricate(:product), Fabricate(:product), Fabricate(:product)] }
           
      before(:each) do
        visit order_path(order)
      end

      it "lists the order ID" do
        page.should have_content(order.id)
      end

      it "lists the user who placed the order" do
        pending "Need to implement users first"
      end

      it "lists the datetime the order was placed" do
        page.should have_content(order.created_at)
      end

      it "lists the datetime the order was updated" do
        page.should have_content(order.updated_at)
      end

      it "lists the total price of all items in the order" do
        page.should have_content(order.total)
      end

      it "has a list of products" do
        page.should have_selector("#items")
      end

      it "lists the products included in the order" do
        within("#items") do
          pending "Return to this - needs to have products added to a cart"
          products.each do |product|
            page.should have_content(product.title)
          end
        end
      end

      it "lists the quantity of each product" do
        pending "TODO: Return when you can add products in a spec to a cart"
      end
      it "lists the line item price of each product" do
        pending "TODO: Return when you can add products in a spec to a cart"
      end

      it "includes a button to edit the order" do
        page.should have_selector("#edit_order_btn")
      end
    end

    context "#new" do
      let!(:product) { Fabricate(:product) }

      before(:each) do
        visit product_path(product)
        click_link_or_button("Add to Cart")
        click_link_or_button("Place Order")
      end

      it "saves shipping information" do
        fill_in "shipping_address_line_1", with: "1234 Street"
        click_link_or_button("Ship to this address")
        page.should have_content("Shipping information saved!")
      end
    end

  end

  context "when logged in as an admin user" do

    let!(:user) { Fabricate(:user, email: "foozberry2@example.com", admin: true) }

    before(:each) do
      visit signin_path
      fill_in "Email",        with: user.email
      fill_in "Password",     with: user.password
      click_button "Sign in"
    end

    context "#index" do
      let!(:orders) { [Fabricate(:order, :user_id => user.id), Fabricate(:order, :user_id => user.id)] }

      before(:each) do
        visit admin_orders_path
      end

      it "has an area that list the orders" do
        page.should have_selector("table#orders")
      end

      it "lists orders in the system" do
        within("table#orders") do
          orders.each do |order|
            page.should have_content(order.id)
          end
        end
      end

      it "lists the status of the orders in its list" do
        within("table#orders") do
          orders.each do |order|
            page.should have_content(order.status)
          end
        end
      end

      it "has a place to sort by status" do
        page.should have_selector("#status_sort")
      end

      it "allows the user to sort by status" do
        pending "Not sure how to set up the selecting on the page itself"
      end

      context "can filter orders by their status" do

        it "lists pending orders" do
          page.should have_selector("#pending_orders")
        end

        it "lists cancelled orders" do
          page.should have_selector("#cancelled_orders")
        end
        
        it "lists paid orders" do
          page.should have_selector("#paid_orders")
        end
        
        it "lists shipped orders" do
          page.should have_selector("#shipped_orders")
        end
        
        it "lists returned orders" do
          page.should have_selector("#returned_orders")
        end
      end

      context "listing total number of products by status" do
        it "has an area to list # of orders by status" do
          page.should have_selector("#status_count")
        end
        it "includes total # of orders" do
          within ("#status_count") do
            page.should have_content(Order.all.count)
          end
        end
        it "lists number of pending orders" do
          within ("#status_count") do
            page.should have_content(Order.find_all_by_status("pending").count)
          end
        end

        it "lists number of cancelled orders" do
          within ("#status_count") do
            page.should have_content(Order.find_all_by_status("cancelled").count)
          end
        end

        it "lists number of paid orders" do
          within ("#status_count") do
            page.should have_content(Order.find_all_by_status("paid").count)
          end
        end

        it "lists number of shipped orders" do
          within ("#status_count") do
            page.should have_content(Order.find_all_by_status("shipped").count)
          end
        end

        it "lists number of returned orders" do
          within ("#status_count") do
            page.should have_content(Order.find_all_by_status("returned").count)
          end
        end

      end
    end

    context "#edit" do
      let!(:product) { Fabricate(:product) }

      before(:each) do
        visit product_path(product)
        click_link_or_button("Add to Cart")
        click_link_or_button("Place Order")
        click_link_or_button("Place Order")
      end

      it "lists the products currently included in the order" do
        page.should have_content(product.title)
      end

      it "loads previous shipping information if the user has defined it"
    end
  end

  context "when not logged in" do
    describe "and the visitor attempts to access the admin order list" do
      it "asks for credentials" do
        visit '/admin/orders/'
        page.should have_content("Sign in")
      end
    end
  end
end