require 'spec_helper'

describe "admin dashboard" do
  include Capybara::DSL

  context "when an admin sign into their dashboard" do

    it "should have orders" do
      user = FactoryGirl.create(:user)
      order = FactoryGirl.create(:order, user: user)
      product = FactoryGirl.create(:product)
      order.order_items << FactoryGirl.create(:order_item, product: product)
      visit '/admin/dashboard'
      expect(page).to have_content(order.products[0].title)
    end
  end

end
