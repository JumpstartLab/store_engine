require 'spec_helper'

describe "Sales" do
  let(:product)     { Fabricate(:product)}
  let(:admin_user)        { Fabricate(:user, :password => 'password',
                                   :admin => 'true') }
  let(:category) { Fabricate(:category) }


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

end
