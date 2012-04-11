require 'spec_helper'

describe "Shopping Cart Requests" do
  let!(:user) { Fabricate(:user) }
  let!(:product) { Fabricate(:product, :title => "iPod") }
  let!(:product2) { Fabricate(:product, :title => "Macbook Pro") }

  before(:each) do
    login_user_post("admin", "admin")
  end

  
  context "when I visit the shopping cart" do
    it "shows the logged in users' cart items " do
      user.shopping_cart = Fabricate(:shopping_cart)
      user.shopping_cart.add_item(product.id, 10)
      visit shopping_cart_path
      find_link(product.title).visible? 
    end

    it "allows me to remove an item from my cart" do
      user.shopping_cart = Fabricate(:shopping_cart)
      user.shopping_cart.add_item(product.id, 10)
      user.shopping_cart.add_item(product2.id, 20)
      visit shopping_cart_path
      click_link("Remove")
      page.should_not have_content(product.title)
      page.should have_content(product2.title)
    end
  end

  context "When I update the shopping cart" do
    let(:cart) { Fabricate(:shopping_cart) }

    before(:each) do
      user.shopping_cart = cart
      cart.add_item(product.id, 10)
    end
    let(:text_field_id) { "quantity[#{cart.cart_items.first.id}]" }

    it "changes the quantity of an item" do
      visit shopping_cart_path
      
      fill_in text_field_id, :with => 3
      click_button("Update Shopping cart")
      find_field(text_field_id).value.should == "3"
    end

    it "changes the quantity of multiple item" do
      cart.add_item(product2.id, 50)
      visit shopping_cart_path
      
      text_field_id2 = "quantity[#{cart.cart_items.second.id}]"
      fill_in text_field_id, :with => 3
      fill_in text_field_id2, :with => 9
      click_button("Update Shopping cart")
      find_field(text_field_id).value.should == "3"
      find_field(text_field_id2).value.should == "9"
    end
  end
end