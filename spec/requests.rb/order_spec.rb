require 'spec_helper'

describe "when viewing an order" do
  let(:user) {FactoryGirl.create(:user)}

  let(:order) {FactoryGirl.create(:order)}
    
  before(:each) { visit order_path(order) }

  it "includes purchaser name" do
    page.should have_content(user.full_name)
  end
end