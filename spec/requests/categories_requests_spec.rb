require 'spec_helper'

describe "Categories Requests" do
  context "index" do

    let!(:categories) { [Fabricate(:category), Fabricate(:category)] }

    before(:each) do
      visit "/categories/"
    end

    it "lists the categories" do
      within("table#categories") do
        categories.each do |category|
          page.should have_selector("td#category_#{category.id}")
        end
      end
    end

    it "links to the categories" do
      within("table#categories") do
        categories.each do |category|
          page.should have_link(category.name, :href => category_path(category))
        end
      end
    end

    it "displays the category when clicking the link" do
      category = categories.first
      within("td##{dom_id(category)}") do
        click_link(category.name)
      end
      current_path.should == category_path(category)
    end
  end

  context "show" do
    let!(:category) { Fabricate(:category) }

    before(:each) do
      visit category_path(category)
    end

    it "displays the name of the category" do
      page.should have_content(category.name)
    end

    it "has a link to the all categories page" do
      page.should have_selector("a[href$='#{categories_path}']")
    end

    it "displays the all products page when clicking the link" do
      click_link("back to all categories")
      current_path.should == categories_path
    end
  end

  context "destroy" do
    let!(:category) { Fabricate(:category) }

    before(:each) do
      visit category_path(category)
    end

    it "has a button to destroy the category" do
      page.should have_selector("#destroy")
    end

    it "destroys the category" do
      pending "This requires approval of JavaScript warning message"
      click_link("Destroy this Category")
      # Need to click the alert box 'ok' here. Test is fine to this point.
      page.should_not have_content(category.name)
    end
  end

  context "new" do
    before(:each) do
      visit new_category_path
    end
    it "displays a form" do
      page.should have_selector("form")
    end

    context "the form" do
      it "asks for a name" do
        within("form") do
          page.should have_selector("label[for$='category_name']")
          page.should have_selector("input[id$='category_name']")
        end
      end
      it "asks for products to be assigned" do
        page.should have_selector("#products")
      end
    end
  end

  context "edit" do
    let!(:category) { Fabricate(:category) }

    before(:each) do
      visit edit_category_path(category)
    end

    it "displays a form" do
      page.should have_selector("form")
    end

    context "the form" do
      it "asks for a name" do
        within("form") do
          page.should have_selector("label[for$='category_name']")
          page.should have_selector("input[id$='category_name']")
        end
      end

      it "asks for products to be assigned" do
        page.should have_selector("#products")
      end
    end
  end

end