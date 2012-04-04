require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do

    it "should have the content 'Store Engine'" do
      visit '/static_pages/home'
      page.should have_content('Store Engine')
    end
  end
end
