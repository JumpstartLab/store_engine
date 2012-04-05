require 'spec_helper'

describe "Create New Product" do
  context "when creating new product" do
    before(:each) do
      visit "/products/new"
    end

    it "creates a new product via the from" do
      within(".new_product") do
        fill_in 'product_title', :with => 'Womb Chair'
        fill_in 'product_description', :with => 'Modern elegance in a minimal package.'
        #attach_file 'image', File.join(Rails.root, 'public', 'uploads', 'product', 'image', '3', 'rails.png')
        fill_in 'product_remote_image_url', :with => ''
      end
      click_button 'Create Product'
      current_path.should == "/products/1"
      a = Product.find_by_title("Womb Chair")
      a.description.should == "Modern elegance in a minimal package."
    end

  end
  
end