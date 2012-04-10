require 'spec_helper'

describe "category_assignments/new" do
  before(:each) do
    assign(:category_assignment, stub_model(CategoryAssignment,
      :product_id => 1,
      :category_id => 1
    ).as_new_record)
  end

  it "renders new category_assignment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => category_assignments_path, :method => "post" do
      assert_select "input#category_assignment_product_id", :name => "category_assignment[product_id]"
      assert_select "input#category_assignment_category_id", :name => "category_assignment[category_id]"
    end
  end
end
