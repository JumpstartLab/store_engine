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

      it "rejects an invalid user" do
        within("#thinForm") do
          fill_in 'user_first_name', :with => 'Worace'
          fill_in 'user_last_name', :with => 'Hilliams'
          fill_in 'user_email', :with => 'user'
          fill_in 'user_password', :with => 'p'
          fill_in 'user_password_confirmation', :with => 'p'
        end
        click_button 'Sign up'
        current_path.should == users_path
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
          page.should have_content(user.full_name)
        end
      end
    end

    context "editing a user" do
      let(:user) {Fabricate(:user)}
      before(:each) do
        login(user)
        visit edit_user_path(user)
      end

      it "successfully updates the user via the form" do
        within(".edit_user") do
          fill_in 'user_first_name', :with => 'Worace'
        end
        click_button 'Update'
        current_path.should == "/"
      end

      it "does not update the user via the form" do
        within(".edit_user") do
          fill_in 'user_first_name', :with => ''
          fill_in 'user_last_name', :with => ''
          fill_in 'user_email', :with => ''
        end
        click_button 'Update'
        current_path.should == user_path(user)
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