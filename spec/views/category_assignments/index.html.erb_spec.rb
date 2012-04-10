require 'spec_helper'

describe "category_assignments/index" do
  before(:each) do
    assign(:category_assignments, [
      stub_model(CategoryAssignment,
        :product_id => 1,
        :category_id => 2
      ),
      stub_model(CategoryAssignment,
        :product_id => 1,
        :category_id => 2
      )
    ])
  end

  it "renders a list of category_assignments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
