require 'spec_helper'

describe "Create New Product" do
  context "when creating new product" do
    let(:admin_user) { Fabricate(:user, :admin => true) }
    let(:user) { Fabricate(:user, :admin => false) }

    context "and logged in as an admin" do
      before(:each) do
        login(admin_user)
        visit "/products/new"
      end

      it "allows admins to create a new product via the from" do
        within(".new_product") do
          fill_in 'product_title', :with => 'Womb Chair'
          fill_in 'product_description', :with => 'Modern elegance in a minimal package.'
          fill_in 'product_price', :with => '500'
          fill_in 'product_remote_image_url', :with => ''
        end
        click_button 'Create Product'
        current_path.should == "/products/1"
        a = Product.find_by_title("Womb Chair")
        a.description.should == "Modern elegance in a minimal package."
      end
    end

    context "and logged in as regular user" do
      
      it "shouldn't even allow the user to access the new action" do
        login(user)
        visit "/products/new"
        current_path.should == "/"
        page.should have_content("DON'T TOUCH THAT")
      end
    end

  end
  
end