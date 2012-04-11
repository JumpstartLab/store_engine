require 'spec_helper'

describe "Cart", :focus => true do
  let!(:user) do 
    FactoryGirl.create(:user, :password => "mike")
  end 
  let!(:products) do
    (1..4).map { FactoryGirl.create(:product)}
  end  
  it "add item to cart" do
    p1 = products.first
    visit product_path(p1)
    click_on "Add To Cart"
    page.should have_content(p1.name)
  end
  context "Add & Remove Items" do
    let(:p1) do
      products[0]
    end
    let(:p2) do
      products[1]
    end
    before(:each) do
      [p1,p2].each do |p|
        visit product_path(p)
        click_on "Add To Cart"
      end
    end
    it "add another item to cart" do
      page.should have_content(p2.name)
      page.should have_content(p1.name)
    end
    it "removes an item from your cart" do
      visit cart_path
      within("#product_#{p1.id}") do
        click_on ("X")
      end
      page.should_not have_content(p1.name)
    end
    context "dealing with login" do
     let!(:cart) do
        FactoryGirl.create(:cart, :user => user, :products => [products[2], products[3]])
      end
      before(:each) do
        [p1,p2].each do |p|
          visit product_path(p)
          click_on "Add To Cart"
        end
        login(user)
        visit cart_path
      end
      it "merges their two carts" do
        products.each do |p|
          page.should have_content(p.name)
        end
      end
    end
    it "increases quantity of a product in cart" do
      cart = FactoryGirl.create(:cart)
      (1..2).each do |i|
        visit product_path(products[3])
        click_on "Add To Cart"
      end
      within("#product_#{products[3].id}") do
        page.should have_content("2")
      end
    end
    it "clears the cart on logout" do
      login(user)
      visit root_path
      click_on "Logout"
      visit '/cart'
      page.should_not have_content(products[3])
    end
  end
  it "counts the total" do
    cart = FactoryGirl.create(:cart)
    products.each do |p|
      visit product_path(p)
      click_on "Add To Cart"
    end    
    visit cart_path
    within("#total") do
      page.should have_content("")
    end
  end
  it "prevents checkout until logged in" do
    pending
  end
  it "checkout" do
    pending
  end
end