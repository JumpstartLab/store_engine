require 'spec_helper'

describe User do
  context "an administrator" do
    it "can create new products" do
      # go to new products page
      # fill out form for new product
      # products count should go up by one
      # product can be found by title
      # redirect to products page

      visit products_path
      click_link "New Product"

      title = Faker::Lorem.words(rand(1..3)).map(&:capitalize).join(" ")
      description = Faker::Lorem.paragraph
      price = (100 * rand).round(2) + 10
      photo = Faker::Internet.url

      fill_in "Title", :with => title
      fill_in "Description", :with => description
      fill_in "Price", :with => price
      fill_in "Photo", :with => photo

      expect {
       click_button "Create Product" 
      }.to change{ Product.all.count }.by(1)

      Product.find_by_title(title).should_not be_nil
    end
  end

  context "an unauthenticated user" do
    it "can't create new products" do
      visit new_product_path
      page.should have_content("Products")
      page.should have_content("Access denied. Please login.")
    end
  end  
end