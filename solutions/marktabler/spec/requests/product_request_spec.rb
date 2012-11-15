  require 'spec_helper'
  describe 'Product request' do
    describe '#index' do
      it "displays an index of existing products" do
        @product = Fabricate(:product)
        visit root_path
        page.should have_content @product.name
      end
    end

    describe '#show' do
      it "displays the detail of an existing product" do
        p = Fabricate(:product)
        visit product_path(p)
        page.should have_content p.description
        page.should have_xpath("//img[@src=\"#{ p.photo_url }\"]")
      end

      it "allows me to add the product to my cart" do
        p = Fabricate(:product)
        visit product_path(p)
        click_button "Add Item To Cart"
        within "#mini_cart" do
          page.should have_content p.name
        end
      end

      it "allows me to add two products to my cart" do
        p = Fabricate(:product)
        visit product_path(p)
        2.times { click_button "Add Item To Cart" }
        within "#mini_cart" do
          page.should have_content p.name
          page.should have_content "2"
        end
      end

      it "shows me a product that is retired" do
        p = Fabricate(:product, retired: true)
        visit product_path(p)
        page.should have_content p.name
      end

      it "does not allow me to buy a retired product" do
        p = Fabricate(:product, retired: true)
        visit product_path(p)
        page.should_not have_button "Add Item To Cart"
      end

      it "allows me to two-click purchase an item" do
        p = Fabricate(:product)
        u = Fabricate(:user)
        log_in(u, 'asdfasdf')
        visit product_path(p)
        click_button "Buy Now"
        page.should have_content "Placed by #{u.email}"
      end

      it "redirects to root for guest users trying to two-click purchase" do
        p = Fabricate(:product)
        visit product_path(p)
        click_button "Buy Now"
        page.should have_content "You must be signed in"
        URI.parse(current_url).path.should == root_path
      end
    end
  end
