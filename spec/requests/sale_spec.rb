require 'spec_helper'

describe "Sale", :focus => true do
  let!(:sale) { FactoryGirl.create(:sale, :percent_off => 50) }
  let!(:category) { FactoryGirl.create(:category, :sale => sale_category) }
  let!(:product) { FactoryGirl.create(:product, :sale => sale, :price_in_cents => 33322) }

  context "View all sales" do
    it "Visit Sale Index" do
      visit "/sales/"
      page.should have_content(product.name)
    end
  end
  context "An admin can create a sale" do
    it "Passes" do
      fill_in "sale[percent_off]", :with => 30
      click_on "Save Sale"
      page.should have_content "Sale created."
    end
    it "Fails" do
      fill_in "sale[percent_off]", :with => 332
      click_on "Save Sale"
      page.should have_content "Please fix the form."
    end    
  end
  context "Sales have end dates " do
    it "Can set end date" do

    end
    it "Can't view a product's sale if the date expired" do

    end
  end

end