require 'spec_helper'

describe "Categories Requests" do

  context "when logged in as an admin" do
    let!(:admin_user) { Fabricate(:user, email: "admin@example.com", admin: true) }

    before(:each) do
      visit signin_path
      fill_in "Email",        with: admin_user.email
      fill_in "Password",     with: admin_user.password
      click_button "Sign in"
    end

    context "#index" do
      let!(:test_category_one)   { Fabricate(:category) }
      let!(:test_category_two)   { Fabricate(:category) }
      let!(:test_category_three) { Fabricate(:category) }
      let!(:categories) { [test_category_one, test_category_two, test_category_three] }

      before(:each) do
        visit categories_path
      end

      it "displays the list of categories" do
        page.should have_content(test_category_one.name)   
        page.should have_content(test_category_two.name)
        page.should have_content(test_category_three.name)
      end
    end

    context "destroy" do
      let!(:category) { Fabricate(:category) }

      before(:each) do
        visit admin_category_path(category)
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
        visit new_admin_category_path
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

      it "creates a new category when the button is clicked" do
        fill_in "category_name",    with: "Test Category"
        click_link_or_button "Create Category"
        page.should have_content("Test Category")
      end
    end

    context "edit" do
      let!(:category) { Fabricate(:category) }

      before(:each) do
        visit edit_admin_category_path(category)
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

      it "saves the content when the 'submit' button is pressed" do
        fill_in "category_name",    with: "Test Updated Category"
        click_link_or_button "Update Category"
        page.should have_content("Test Updated Category")
      end
    end
  end

  context "When logged in as a non-admin user" do
    let!(:user) { Fabricate(:user, email: "foozberry@example.com") }

    before(:each) do
      visit signin_path
      fill_in "Email",        with: user.email
      fill_in "Password",     with: user.password
      click_button "Sign in"
    end

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
    end
  end

  context "when logged in as a basic user" do
    let!(:user) { Fabricate(:user, email: "foozberry@example.com") }

    before(:each) do
      visit signin_path
      fill_in "Email",        with: user.email
      fill_in "Password",     with: user.password
      click_button "Sign in"
      visit categories_path
    end

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

      it "clicking 'back to all categories' takes you to products index" do
        click_link_or_button("all categories")
        current_path.should == categories_path
      end
    end
  end

  context "when not logged in" do
    before(:each) do
      visit categories_path
    end

    it "should not allow you to edit the categories" do
      visit admin_categories_path
      page.should_not have_selector(".category_form")
    end
  end
end