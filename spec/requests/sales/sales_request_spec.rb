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
        within("#new_category") do
          fill_in 'category_name', :with => "#{category.name}"
        end
      current_path.should == sale_path
    end
  end

end
