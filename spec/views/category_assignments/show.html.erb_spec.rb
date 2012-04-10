require 'spec_helper'

describe "category_assignments/show" do
  before(:each) do
    @category_assignment = assign(:category_assignment, stub_model(CategoryAssignment,
      :product_id => 1,
      :category_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
