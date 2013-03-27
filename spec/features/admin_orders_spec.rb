require 'spec_helper'

describe "admin dashboard" do
  context "when an admin visits their dashboard" do
    it "should have a list of all orders" do
      user = FactoryGirl.create(:user)
      order1 = FactoryGirl.create(:order, user: user)
      product = FactoryGirl.create(:product)
      order2 = FactoryGirl.create(:order, user: user)
      order1.order_items << FactoryGirl.create(:order_item, product: product)
      order2.order_items << FactoryGirl.create(:order_item, product: product)
      visit '/admin/dashboard'

      expect(page).to have_xpath("//a[@href='#{admin_order_path(order1)}']")
      expect(page).to have_xpath("//a[@href='#{admin_order_path(order2)}']")
    end

    xit "should link to individual orders" do
    end

    xit "should show a total number of orders by status" do
      # "pending", "cancelled", "paid", "shipped", "returned"
    end

    xit "should allow for filtering by status" do
    end

    context "within an individual order" do
      xit "displays order creation date and time" do
      end

      xit "displays purchaser's full name and email address" do
      end

      xit "displays each product of the order with associated data" do
        # Name with link to product page
        # Quantity
        # Price
        # Line item subtotal
      end

      xit "displays order total" do
      end

      xit "displays order status" do
      end

      context "can update the order by" do
        xit "progressing status based on rules" do
          # link to "cancel" individual orders which are currently "pending"
          # link to "mark as returned" individual orders which are currently "shipped"
          # link to "mark as shipped" individual orders which are currently "paid"
        end

        xit "changing quantity or removing products ONLY when status pending or paid" do
        end
      end
    end
  end
end
