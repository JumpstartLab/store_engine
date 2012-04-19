require 'spec_helper'

describe "Categories Requests" do

  context "when logged in as an admin" do
    context "destroy" do
      let!(:category) { Fabricate(:category) }

      before(:each) do
        visit category_path(category)
      end

      it "has a button to destroy the category" do
        pending "Need to set these tests up with admin access"
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

      # it "displays a form" do
      #   pending "Need to set these tests up with admin access"
      #   page.should have_selector("form")
      # end

      # context "the form" do
      #   it "asks for a name" do
      #     pending "Need to set these tests up with admin access"
      #     within("form") do
      #       page.should have_selector("label[for$='category_name']")
      #       page.should have_selector("input[id$='category_name']")
      #     end
      #   end
      #   it "asks for products to be assigned" do
      #     pending "Need to set these tests up with admin access"
      #     # page.should have_selector("#products")
      #   end
      # end
    end

    # context "edit" do
    #   let!(:category) { Fabricate(:category) }

    #   before(:each) do
    #     visit edit_category_path(category)
    #   end

    #   it "displays a form" do
    #     pending "Admin Login setup"
    #     page.should have_selector("form")
    #   end

    #   context "the form" do
    #     it "asks for a name" do
    #       pending "admin login setup"
    #       within("form") do
    #         page.should have_selector("label[for$='category_name']")
    #         page.should have_selector("input[id$='category_name']")
    #       end
    #     end

    #     it "asks for products to be assigned" do
    #       pending "admin login setup"
    #       page.should have_selector("#products")
    #     end
    #   end
    # end

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
end