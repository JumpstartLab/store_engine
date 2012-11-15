require 'spec_helper'

describe "Cart" do
  let!(:real_address) do
    FactoryGirl.create(:address)
  end
  let!(:user) do 
    FactoryGirl.create(:user, :password => "mike", :address => real_address, :stripe_id => "cus_aAiayNrIfqHjGZ")
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
    context "update quantity of cart" do
      before(:each) do
        visit cart_path
      end
      it "With valid number" do
        within("#product_#{p1.id}") do
          fill_in "cart[order_products_attributes][0][quantity]", :with => 5
        end
        click_on "Update Cart"
        page.should have_content("Cart updated successfully")
      end
      it "with an invalid number" do
        within("#product_#{p1.id}") do
          fill_in "cart[order_products_attributes][0][quantity]", :with => -5
        end
        click_on "Update Cart"
        #save_and_open_page
        page.should have_content(5)        
      end
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
    it "increases quantity of a product in cart by adding it again" do
      cart = FactoryGirl.create(:cart)
      (1..2).each do |i|
        visit product_path(products[3])
        click_on "Add To Cart"
      end
      page.should have_content("Product added to cart")
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
  it "Buys with two clicks" do
    login(user)
    visit product_path(products[3])
    click_on("Buy Instantly!")
    page.should have_content("Congrats on giving us your money")
  end  
end