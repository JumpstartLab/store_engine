require 'spec_helper'

describe "Cart Items Requests" do
  let!(:product) { Fabricate(:product, :id => 1, :title => "Foo") }

  # Create new cart items
  context "When creating a new cart item" do
    it "redirects to the shopping cart" do
      login_user_post("austen", "test")
      visit "/products/1"
      find_button('Add to Cart').click
      current_path.should == shopping_cart_path
    end
  end
  # redirect to the cart controller's index
end

module Sorcery
  module TestHelpers
    module Rails
      def login_user_post(user, password)
        page.driver.post(user_sessions_url, { username: user, password: password}) 
      end
    end
  end
end