require 'spec_helper'

describe "Cart" do
  let!(:user) do 
    FactoryGirl.create(:user)
  end 
  let!(:products) do
    (1..3).map { FactoryGirl.create(:product)}
  end  
  it "add item to cart" do
    p1 = products.first
    visit product_path(p1)
    click_on "Add Item"
    page.should have_content(p1.name)
  end
  it "add another item to cart" do
    p1 = products.first
    p2 = products.last
    [p1,p2].each do |p|
      visit product_path(p)
      click_on "Add Item"
    end
    page.should have_content(p2.name)
    page.should have_content(p1.name)
  end
end