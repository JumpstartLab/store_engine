require 'spec_helper'

describe "Create New Category" do
  let(:category) { Fabricate(:category) }
  let(:user)     { Fabricate(:user,
                    :password => 'password',
                    :admin => true)}
  context "as an admin" do
    before(:each) do
      login(user)
    end

    context "when creating new category" do
      before(:each) do
        visit "/categories/new"
      end

      it "creates a new category via the from" do
        within(".new_category") do
          fill_in 'category_name', :with => 'Pulpy Romance Novels'
        end
        click_button 'Create Category'
        current_path.should == "/categories"
        page.should have_link("Pulpy Romance Novels")
      end
    end

  end

end