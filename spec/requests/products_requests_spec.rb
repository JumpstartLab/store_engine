require 'spec_helper'

describe "Products Requests" do
  context "root" do
    let!(:products) { [Fabricate(:product), Fabricate(:product)] }

    before(:each) { visit "/" }

    it "links to the product" do
      within("table.table-striped") do
        products.each do |product|
          page.should have_selector("td##{dom_id(product)}")
          page.should have_link(product.title, href: product_path(product))
        end
      end
    end
  end
end