require 'spec_helper'

describe "orders/new" do
  before(:each) do
    assign(:order, stub_model(Order,
      :user_id => 1,
      :product_id => 1,
      :status => "MyString"
    ).as_new_record)
  end

  it "renders new order form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => orders_path, :method => "post" do
      assert_select "input#order_user_id", :name => "order[user_id]"
      assert_select "input#order_product_id", :name => "order[product_id]"
      assert_select "input#order_status", :name => "order[status]"
    end
  end
end
