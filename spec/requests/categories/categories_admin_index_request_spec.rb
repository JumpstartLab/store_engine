require 'spec_helper'

describe "Categories Admin Requests" do
  context "as an admin" do
    before(:each) do
      @user = Fabricate(:user,
                        :password => 'password',
                        :admin => true)
      visit "/login"
      fill_in 'email', :with => @user.email
      fill_in 'password', :with => 'password'
      click_button 'Log in'
    end

    it "shows a link to add a category" do
      visit "/categories"
      within("#add_link") do
        page.should have_link('Add a category',
                              href: new_category_path)
      end
    end

  end
end