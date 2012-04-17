require 'spec_helper'

describe "Create New User" do
  
  context "when creating a new user" do

    context "and there are no items in the cart" do
      before(:each) do
        visit "/signup"
      end

      it "creates a new user via the form" do
        within("#thinForm") do
          fill_in 'user_first_name', :with => 'Worace'
          fill_in 'user_last_name', :with => 'Hilliams'
          fill_in 'user_email', :with => 'user@example.com'
          fill_in 'user_password', :with => 'password'
          fill_in 'user_password_confirmation', :with => 'password'
        end
        click_button 'Sign up'
        current_path.should == "/"
        user = User.find_by_first_name("Worace")
        @users = User.all
        @users.should include(user)
      end

      it "logs in the new user" do
        within("#thinForm") do
          fill_in 'user_first_name', :with => 'Worace'
          fill_in 'user_last_name', :with => 'Hilliams'
          fill_in 'user_email', :with => 'user@example.com'
          fill_in 'user_password', :with => 'password'
          fill_in 'user_password_confirmation', :with => 'password'
        end
        click_button 'Sign up'
        user = User.find_by_first_name("Worace")
        within(".dropdown-menu") do
          page.should have_content(user.name)
        end
      end
    end

    context "and there are items in the cart" do
      let!(:product) {Fabricate(:product)}

      it "retains products added to the new user's cart prior to signup" do
        visit product_path(product)
        click_link_or_button "add to cart"
        visit "/signup"
        within("#thinForm") do
          fill_in 'user_first_name', :with => 'Worace'
          fill_in 'user_last_name', :with => 'Hilliams'
          fill_in 'user_email', :with => 'user@example.com'
          fill_in 'user_password', :with => 'password'
          fill_in 'user_password_confirmation', :with => 'password'
        end
        click_button 'Sign up'
        visit "/cart"
        page.should have_content(product.title)
      end
    end

  end
  
end