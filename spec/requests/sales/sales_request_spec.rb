require 'spec_helper'

describe "Sales" do
  let(:product)     { Fabricate(:product)}
  let(:admin_user)        { Fabricate(:user, :password => 'password',
                                   :admin => 'true') }
  let(:user)        { Fabricate(:user) }
  let(:category) { Fabricate(:category) }
  let(:product2) { Fabricate(:product, :price => 100.00) }
  let(:sale)     { Sale.create(:percentage => 50, :endtime => Time.now + 1400000) }
  let(:sale2)     { Sale.create(:percentage => 75, :endtime => Time.now + 1400000) }



  context "when creating a sale" do
    it "lets me create a sale for a product" do
      login(admin_user)
      visit product_path(product)
      click_link_or_button("Put on sale")
      fill_in 'sale_percentage', :with => "25"
      fill_in 'sale_endtime', :with => "2012-05-17"
      click_button 'Create Sale'
      sale = Sale.last
      current_path.should == sale_path(sale)
    end

    it "lets me create a sale for a category" do
      login(admin_user)
      visit category_path(category)
      click_link_or_button("Put on sale")
      fill_in 'sale_percentage', :with => "25"
      fill_in 'sale_endtime', :with => "2012-05-17"
      click_button 'Create Sale'
      sale = Sale.last
      current_path.should == sale_path(sale)
    end
  end

  context "when viewing a product on sale" do
    before(:each) do
      product2.sale = sale
      product2.save
    end

    it "shows the updated price for the product" do
      visit product_path(product2)
      within("#sale_price") do
        page.should have_content("$50.00")
      end
    end

    it "gives the best price between a product and a category sale" do
      category.sale = sale2
      category.products << product2
      category.save
      visit product_path(product2)
      within("#sale_price") do
        page.should have_content("$25.00")
      end
    end
  end

  it "places a product on sale through a category" do
    category.sale = sale2
    category.products << product2
    category.save
    visit product_path(product2)
    within("#sale_price") do
      page.should have_content("$25.00")
    end
  end
end
