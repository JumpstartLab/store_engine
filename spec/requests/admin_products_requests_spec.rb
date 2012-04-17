require 'spec_helper'

describe "Products Requests" do
  context "when an admin is logged in" do
    let!(:user) { Fabricate(:user, :admin => true) }
    let!(:product) { Fabricate(:product) }
    let!(:category) { Fabricate(:category) }
    let!(:category2) { Fabricate(:category) }

    before(:each) { login }

    context "when I create a product" do
      before(:each) do
        visit new_admin_product_path
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

      it "redirects to admin products path" do
        click_button "Create Product"
        current_path.should == admin_products_path
      end

      context "and no categories are chosen" do
        it "saves a new product with no categories" do
          click_button "Create Product"
          click_link "Test product"
          within("#admin_product_show") do
            page.should_not have_content(category.name)
            page.should_not have_content(category2.name)
          end
        end
      end
    end

    context "when I view a product" do 
      let!(:product) { Fabricate(:product, :title => "Foo") }

      it "shows product page" do
        visit admin_products_path 
        find_link("Foo").click
        current_path.should == admin_product_path(product)
      end
    end

    context "When I edit a product" do
      before(:each) do
        product.categories << category2
        visit edit_admin_product_path(product)
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
        within("#admin_product_show") do
          page.should have_content(category2.name)
          page.should_not have_content(category.name)
        end
      end

      it "redirects to admin products page" do
        click_button("Update Product")
        current_path.should == admin_product_path(product)
      end

      context "and no categories are selected" do
        it "saves no categories" do
          other_product = Fabricate(:product)
          visit edit_admin_product_path(other_product)
          click_button("Update Product")
          within("#admin_product_show") do
            page.should_not have_content(category.name)
            page.should_not have_content(category2.name)
          end
        end
      end
    end
  end

  context "when not an admin" do
    let(:product) { Fabricate(:product) }

    it "shows users page not found" do
      validate_not_found(admin_products_path)
    end

    it "shows new user page not found" do
      validate_not_found(new_admin_product_path)
    end

    it "shows create user page not found" do
      validate_not_found(admin_products_path(product), "post")
    end
    it "shows user page not found" do
      validate_not_found(admin_product_path(product))
    end

    it "shows user edit page not found" do
      validate_not_found(edit_admin_product_path(product))
    end

    it "shows user update page not found" do
      validate_not_found(admin_product_path(product), "put")
    end
  end
end
