require 'spec_helper'
  describe 'Admin Product' do
    it "allows an admin to view a product" do
      u = Fabricate(:user)
      p = Fabricate(:product)
      u.update_attribute(:admin, true)
      log_in(u, 'asdfasdf')
      visit admin_product_path(p)
      page.should have_content p.name
    end

    it "allows an admin to retire a product" do
      u = Fabricate(:user)
      p = Fabricate(:product)
      u.update_attribute(:admin, true)
      log_in(u, 'asdfasdf')
      visit edit_admin_product_path(p)
      click_link "Retire"
      page.should_not have_link "Retire"
      page.should have_link "Unretire"
    end


    it "allows an admin to unretire a product" do
      u = Fabricate(:user)
      p = Fabricate(:product, retired: true)
      u.update_attribute(:admin, true)
      log_in(u, 'asdfasdf')
      visit edit_admin_product_path(p)
      click_link "Unretire"
      page.should_not have_link "Unretire"
      page.should have_link "Retire"
    end    

  end