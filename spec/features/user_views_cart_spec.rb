require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'the user cart view', type: :feature do
  context "when there are no items in the cart" do
    it 'displays a message that the cart is empty' do
      visit '/cart'
      expect(page).to have_content("empty")
    end
  end

  context "when there are items in the cart" do
    before do
      FactoryGirl.create(:product)
      FactoryGirl.build(:product)
      p1 = Product.first
      visit product_path(p1)
      click_button 'Add To Cart'
      visit '/cart'
    end

    it 'shows the cart with items quantities and prices' do
      expect(page).to have_content("Total")
    end

    context "the user wants to empty the cart" do
      it "gets emptied" do
        click_button 'Empty Cart'
        expect(page).to have_content("empty")
      end
    end
  end

end
