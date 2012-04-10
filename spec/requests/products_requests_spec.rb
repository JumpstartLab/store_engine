require 'spec_helper'

describe "Products Requests" do
  context "products" do

    let!(:products) { [Fabricate(:product), Fabricate(:product)] }

    before(:each) do
      visit "/products/"
    end

    it "lists the products" do
      within("table#products") do
        products.each do |product|
          page.should have_selector("#product_#{product.id}")
        end
      end
    end

    it "links to the products" do
      within("table#products") do
        products.each do |product|
          page.should have_link(product.title, :href => product_path(product))
        end
      end
    end

    it "displays the product when clicking the link" do
      product = products.first
      within("#product_#{product.id}_add") do
        click_link(product.title)
      end
      current_path.should == product_path(product)
    end

    it "has a link to the add product page" do
      page.should have_selector("a#add_product")
    end

    it "displays the add product page when clicking the link" do
      click_link("add_product")
      current_path.should == new_product_path
    end
  end

  context "show" do
    let!(:product) { Fabricate(:product) }

    before(:each) do
      visit product_path(product)
    end

    it "displays the title of the product" do
      # within("h1") do
        page.should have_content(product.title)
      # end
    end

    it "displays the description of the product" do
      page.should have_content(product.description)
    end

    it "displays the photo of the product" do
      page.should have_selector("img[src$='#{product.photo}']")
    end

    it "displays the price of the product" do
      page.should have_content(product.price)
    end

    it "displays the category of the product" do
      pending "Need to properly handle categories"
      page.should have_content(product.category_id)
    end

   it "has a link to all products page" do
      page.should have_selector("a[href$='#{products_path}']")
    end

    it "displays the add product page when clicking the link" do
      click_link("back to all products")
      current_path.should == products_path
    end 

    it "has a link to the edit this product page" do
      page.should have_selector("a[href$='#{edit_product_path(product)}']")
    end

    it "displays the add product page when clicking the link" do
      click_link("edit this product")
      current_path.should == edit_product_path(product)
    end 

    it "has a link to the delete this product page" do
      page.should have_selector("a[href$='#{product_path(product)}'][data-method$='delete']")
    end

    it "displays the products when clicking the link" do
      click_link("delete this product")
      current_path.should == products_path
    end

    it "deletes the product when clicking the link" do
      click_link("delete this product")
      within("table#products") do
        page.should_not have_link(product.title, :href => product_path(product))
      end
    end  

  end

  context "new" do
    before(:each) do
      visit new_product_path
    end

    it "displays a form" do
      page.should have_selector("form")
    end

    context "the form" do

      it "asks for a title" do
        within("form") do
          page.should have_selector("label[for$='product_title']")
          page.should have_selector("input[id$='product_title']")
        end
      end

      it "asks for a product description" do
        within("form") do
          page.should have_selector("label[for$='product_description']")
          page.should have_selector("textarea[id$='product_description']")
        end
      end

      it "asks for a product price" do
        within("form") do
          page.should have_selector("label[for$='product_price']")
          page.should have_selector("input[id$='product_price']")
        end
      end

      it "asks for a product photo" do
        within("form") do
          page.should have_selector("label[for$='product_photo']")
          page.should have_selector("input[id$='product_photo']")
        end
      end

      it "asks for a product category" do
        within("form") do
          page.should have_selector("label[for$='product_category_id']")
          page.should have_selector("input[id$='product_category_id']")
        end
      end

      it "asks if the product is retired" do
        within("form") do
          page.should have_selector("label[for$='product_retired']")
          page.should have_selector("input[name$='product[retired]'][type$='checkbox']")
        end
      end
    end
  end


  context "edit" do

    let!(:product) { Fabricate(:product) }

    before(:each) do
      visit edit_product_path(product)
    end

    it "displays a form" do
      page.should have_selector("form")
    end

    context "the form" do

      it "asks for a title" do
        within("form") do
          page.should have_selector("label[for$='product_title']")
          page.should have_selector("input[id$='product_title']")
        end
      end

      it "knows the old title" do
        within("form") do
          page.should have_selector("input[id$='product_title'][value$='#{product.title}']")
        end
      end

      it "asks for a product description" do
        within("form") do
          page.should have_selector("label[for$='product_description']")
          page.should have_selector("textarea[id$='product_description']")
        end
      end

      it "knows the old description" do
        within("form") do
          page.should have_content(product.description)
        end
      end

      it "asks for a product price" do
        within("form") do
          page.should have_selector("label[for$='product_price']")
          page.should have_selector("input[id$='product_price']")
        end
      end

      it "knows the old product price" do
        within("form") do
          page.should have_selector("input[id$='product_price'][value$='#{product.price}']")
        end
      end

      it "asks for a product photo" do
        within("form") do
          page.should have_selector("label[for$='product_photo']")
          page.should have_selector("input[id$='product_photo']")
        end
      end

      it "knows the old photo" do
        within("form") do
          page.should have_selector("input[id$='product_photo'][value$='#{product.photo}']")
        end
      end

      it "asks for a product category" do
        within("form") do
          page.should have_selector("label[for$='product_category_id']")
          page.should have_selector("input[id$='product_category_id']")
        end
      end

      it "knows the old category" do
        within("form") do
          page.should have_selector("input[id$='product_category_id'][value$='#{product.category_id}']")
        end
      end

      it "asks if the product is retired" do
        within("form") do
          page.should have_selector("label[for$='product_retired']")
          page.should have_selector("input[name$='product[retired]'][type$='checkbox']")
        end
      end

      it "knows the old retired status" do
        within("form") do
          pending "Need to understand testing checkboxes for truthyness"
          page.should have_selector("input[id$='product_title'][value$='#{product.title}']")
        end
      end
    end
  end

  context ""

end