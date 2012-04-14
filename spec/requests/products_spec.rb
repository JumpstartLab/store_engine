require 'spec_helper'

describe "Products" do
  let!(:products) do
    (1..5).map { FactoryGirl.create(:product) }
  end
  let!(:retired_product) { FactoryGirl.create(:product, :activity => false) }
  let!(:user) { FactoryGirl.create(:user, :admin => true) }

  describe "GET /products" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get products_path
      response.status.should be(200)
    end
  end

  context "when I'm on the products page" do
    before(:each) { visit products_path }
    it "does not display retired products" do
      visit products_path
      page.should_not have_content(retired_product.title)
    end
  end
end
