require 'spec_helper'

describe 'the user cart view' do
  context "when there are no items in the cart" do
    it 'displays a message that the cart is empty' do
      visit '/cart'
      expect(page).to have_content("empty")
    end
  end

  context "when there are items in the cart" do
    before do
      product = FactoryGirl.create(:product)
      visit product_path(product)
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
