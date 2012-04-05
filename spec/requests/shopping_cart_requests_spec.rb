require 'spec_helper'

describe "Shopping Cart Requests" do
  context "GET show action" do
    let!(:cart_item) do
      Fabricate(:cart_item, :product => Fabricate(:product, :title => "iPod"))
    end

    before(:each) do
      login_user_post("austen", "test")
      visit '/shopping_cart'
    end

    # it "list the current cart items" do
    #   find_link("iPod").visible? 
    # end

  end
end