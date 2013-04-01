require File.dirname(__FILE__) + '/../spec_helper'

describe Search do
  describe '.filter_products' do
    context 'when both active and retired products exist in db' do

      before(:each) do
        @user = FactoryGirl.create(:user)
        nicknacks = FactoryGirl.create(:category, title: 'nicknacks')
        superheroes = FactoryGirl.create(:category, title: 'superheroes')
        FactoryGirl.create(:product, categories: [nicknacks], title: 'gum', description: 'sticky', status: 'active', price: 2.99)
        FactoryGirl.create(:product, categories: [superheroes], title: 'envelope', description: 'green', status: 'active', price: 18.99)
        FactoryGirl.create(:product, categories: [nicknacks], title: 'cup', description: 'half-full', status: 'retired', price: 1.99)
      end

      it 'returns all active products in db when no category is specified (default homepage load)' do
        products = Search.filter_products
        expect(products.count).to eq 2
      end

      it 'returns all active products for the specified category' do
        products = Search.filter_products({category_id: 1})
        expect(products.count).to eq 1
      end
    end
  end

  describe '.filter_user_orders' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      product1 = FactoryGirl.create(:product, title: 'Sweaty Hair', description: 'Sticky')
      product2 = FactoryGirl.create(:product, title: 'Dancing Bird', description: 'Something')
      product3 = FactoryGirl.create(:product, title: 'Flocking Buffalo', description: 'Crossfit sweat')
      FactoryGirl.create(:order, user: @user).order_items = [FactoryGirl.create(:order_item, product: product1)]
      FactoryGirl.create(:order, user: @user).order_items = [FactoryGirl.create(:order_item, product: product2)]
      FactoryGirl.create(:order, user: @user).order_items = [FactoryGirl.create(:order_item, product: product3)]
    end

    it 'returns the matching orders based on title and description' do
      expect(Search.filter_user_orders(@user.id, {search: 'sweat'}).count).to eq 2
    end

    it 'returns all orders if no search term given' do
      expect(Search.filter_user_orders(@user.id).count).to eq 3
    end
  end
end
