require 'spec_helper'

describe 'viewing all orders' do
  describe 'when user is not logged in' do
    it "it redirects to login page" do
      visit "/orders"
      page.should have_content "You need to log in first."
    end
  end
  
  describe 'when user is logged in' do
    let(:user) { Fabricate(:user) }
  end
end