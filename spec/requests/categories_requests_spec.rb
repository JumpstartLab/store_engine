require 'spec_helper'

describe "Categories Requests" do
  let!(:category) { Category.create(:name => "Apples") }
  let!(:category2) { Category.create(:name => "Oranges") }

  context "GET index" do
    before(:each) do
      visit '/categories'
    end

    it "shows Product Categories header" do
      page.should have_content("Product Categories")
    end

    it "shows all of the categories" do
      page.should have_content("Apples")
      page.should have_content("Oranges")
    end

    it "creates a list of the categories" do
      within ("li") do
        page.should have_content("Apples")
      end
    end   
  end
end