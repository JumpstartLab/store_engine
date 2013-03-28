require 'spec_helper'

describe "admin dashboard" do
  context "when an admin visits their dashboard" do
    it "should have a list of all orders and link to each" do
      user = FactoryGirl.create(:user)
      order1 = FactoryGirl.create(:order, user: user)
      order2 = FactoryGirl.create(:order, user: user)

      visit '/admin/dashboard'
      expect(page).to have_xpath("//a[@href='#{admin_order_path(order1)}']")
      expect(page).to have_xpath("//a[@href='#{admin_order_path(order2)}']")
    end

    it "should show a total number of orders by status" do
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:order, user: user, status: 'paid')
      FactoryGirl.create(:order, user: user, status: 'paid')
      FactoryGirl.create(:order, user: user, status: 'returned')

      visit '/admin/dashboard'
      expect(page).to have_content('0 pending')
      expect(page).to have_content('2 paid')
      expect(page).to have_content('1 returned')
      expect(page).to have_content('0 shipped')
      expect(page).to have_content('0 cancelled')
    end

    xit "should allow for filtering by status" do
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:order, user: user, status: 'paid')
      FactoryGirl.create(:order, user: user, status: 'paid')
      FactoryGirl.create(:order, user: user, status: 'returned')

      visit '/admin/dashboard'

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
