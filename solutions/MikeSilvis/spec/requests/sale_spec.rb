require 'spec_helper'

describe "Sale", :focus => true do
  let!(:user) { FactoryGirl.create(:admin, :password => "mike")}
  let!(:sale) { FactoryGirl.create(:sale, :percent_off => 50) }
  let!(:category) { FactoryGirl.create(:category, :sale => sale) }
  let!(:product) { FactoryGirl.create(:product, :sale => sale, :price_in_cents => 33322) }

  context "View all sales" do
    it "Visit Sale Index" do
      visit sales_path
      page.should have_content(product.name)
    end
  end
  before(:each) do
    login(user)
  end
  context "An admin can create a sale" do
    before(:each) do
      visit new_admin_sale_path
    end
    it "Passes" do
      fill_in "sale[percent_off]", :with => 30
      select('2014', :from => 'sale[end_at(1i)]')
      click_on "Save Sale"
      page.should have_content "Sale created."
    end
    it "Fails" do  
      fill_in "sale[percent_off]", :with => 332
      click_on "Save Sale"
      page.should have_content "Please fix the form."
    end    
  end
  context "An admin can modify a sale" do
    before(:each) do
      visit edit_admin_sale_path(sale)
    end
    it "Passes" do
      fill_in "sale[percent_off]", :with => 30
      select('2014', :from => 'sale[end_at(1i)]')
      click_on "Save Sale"
      page.should have_content "Sale updated."      
    end
    it "Fails" do
      fill_in "sale[percent_off]", :with => 332
      click_on "Save Sale"
      page.should have_content "is not included in the list"
    end
  end
  context "Can delete a sale" do
    it "deletes a sale" do
      visit admin_sales_path
      within("#sale_#{sale.id}") do
        click_on "X"
      end
      page.should have_content "Sale Removed"
    end
  end

end