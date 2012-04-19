require 'spec_helper'

describe "Creating Shipping Detail" do
  before do
    visit new_shipping_detail_path
  end

  it "should show the new shipping details page" do
    page.should have_content "Add a Shipping Address"
  end

end
