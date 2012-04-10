require 'spec_helper'

describe "Products Requests" do
  context "when I view all products" do
    let!(:products) { [Fabricate(:product, :title => "Foo"), 
      Fabricate(:product, :title => "Bar")] }
      before(:each) do      
        visit products_path
      end

      it "shows Products header" do
        page.should have_content("Products")
      end

      it "shows all of the products" do
        find_link("Foo").visible?
        find_link("Bar").visible?
      end

      it "creates a list of the products" do
        within ("li") do
          find_link("Foo").visible?
        end
      end
    end

    context "when I create a product" do
      let!(:category) { Fabricate(:category) }
      let!(:category2) { Fabricate(:category) }

      before(:each) do
        visit new_product_path
        fill_in "Title", :with => "Test product"
        fill_in "Description", :with => "Test description"
        fill_in "Price", :with => "100.00"
      end

      it "saves a new product" do
        check "category[#{category2.name}]"

        click_button "Create Product"
        click_link "Test product"
        page.should have_content("Test product")
        page.should have_content("Test description")
        page.should have_content("100.00")
        page.should have_content(category2.name)
      end

      context "and no categories are chosen" do
        it "saves a new product with no categories" do
          click_button "Create Product"
          click_link "Test product"
          page.should_not have_content(category.name)
          page.should_not have_content(category2.name)
        end
      end
    end

    context "when I view a product" do 
      let!(:product) { Fabricate(:product, :title => "Foo") }

      it "shows product page" do
        visit products_path 
        find_link("Foo").click
        current_path.should == product_path(product)
      end

      it "shows quantity selector with 30 items" do 
        visit product_path(product)
        (1..30).each do |i| 
          select(i.to_s, :from => 'cart_item_quantity')
        end
      end

      it "has a Add to Cart submit button" do
        visit product_path(product)
        find_button("Add to Cart").visible?
      end

      it "has a link to edit the product" do
        visit product_path(product)
        click_link("Edit Product")
        current_path.should == edit_product_path(product)
      end
    end

    context "When I edit a product" do
      let!(:product) { Fabricate(:product) }
      let!(:category) { Fabricate(:category) }
      let!(:category2) { Fabricate(:category) }

      before(:each) do
        product.categories << category2
        visit edit_product_path(product)
      end

      it "has category 2 checked" do
        category2_box = find("#category_#{category2.name}")
        category2_box.checked?.should == "checked"
      end

      it "saves title " do
        fill_in "Title", :with => "Bar"
        click_button("Update Product")
        page.should have_content("Bar")
      end

      it "saves description" do
        fill_in "Description", :with => "New description"
        click_button("Update Product")
        page.should have_content("New description")
      end

      it "saves price" do
        fill_in "Price", :with => "100"
        click_button("Update Product")
        page.should have_content("100.00")
      end


      it "saves categories" do
        check "category[#{category2.name}]"
        click_button("Update Product")
        page.should have_content(category2.name)
        page.should_not have_content(category.name)
      end

      context "and no categories are selected" do
        it "saves no categories" do
          other_product = Fabricate(:product)
          visit edit_product_path(other_product)
          click_button("Update Product")
          page.should_not have_content(category.name)
          page.should_not have_content(category2.name)
        end
      end
    end

    context "When I click on the 'add to cart' button" do
      let!(:user) { Fabricate(:user) }
      let!(:product) { Fabricate(:product, :id => 1, :title => "Foo") }

      it "redirects to the shopping cart" do
        login_user_post("admin", "admin")
        visit product_path(product)
        find_button('Add to Cart').click
        current_path.should == shopping_cart_path
      end
    end
  end
