require 'spec_helper'


describe "two click checkout process" do
  after(:each) do
    Product.all.clear
  end

  it "when the user is anonymous" do
    FactoryGirl.create(:product, title: 'gum', description: 'sticky', status: 'active', price: 2.99)
    visit '/products/1'
    click_button('2-Click')
    page.should have_content('Login')
  end
end