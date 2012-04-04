require 'spec_helper'

describe "Cart" do
  let!(:user) do 
    FactoryGirl.create(:user)
  end 
  let!(:products) do
    (1..3).map { FactoryGirl.create(:product)}
  end  
  it "add items to cart" do
    visit product_path(products.first)
      click_on "Add Item"
      save_and_open_page
  end
end