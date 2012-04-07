require 'spec_helper'

describe "Cart", :focus => true do
  let!(:user) do 
    FactoryGirl.create(:user, :password => "mike")
  end 
  let!(:products) do
    (1..5).map { FactoryGirl.create(:product)}
  end  
  it "add item to cart" do
    p1 = products.first
    visit product_path(p1)
    click_on "Add Item"
    page.should have_content(p1.name)
  end
  context "Add & Remove Items" do
    let(:p1) do
      products.first
    end
    let(:p2) do
      products.last
    end
    before(:each) do
      [p1,p2].each do |p|
        visit product_path(p)
        click_on "Add Item"
      end
    end
    it "add another item to cart" do
      page.should have_content(p2.name)
      page.should have_content(p1.name)
    end
    it "removes an item from your cart" do
      visit cart_path
      within("#product_#{p1.id}") do
        click_on ("Remove Item")
      end
      page.should_not have_content(p1.name)
    end
    context "dealing with login" do
     let!(:cart) do
        FactoryGirl.create(:cart, :user => user, :products => [products[2], products[3]])
      end
      before(:each) do
        [products.first,products.last].each do |p|
          visit product_path(p)
          click_on "Add Item"
        end
        #save_and_open_page
        login(user)
        visit cart_path
        #save_and_open_page
      end
      it "keeps the cart when logged in" do
        page.should have_content(p2.name)
        page.should have_content(p1.name)   
      end
      it "merges their two carts" do
        pending
      end
      context "when they have a cart" do
        it "finds their current cart" do
          #save_and_open_page
          page.should have_content(products[2].name)
          page.should have_content(products[3].name)
        end
      end
    end
  end
  it "increases quantity of a product in cart" do
    pending
  end
  it "prevents checkout until logged in" do
    pending
  end
  it "checkout" do
    
  end
end