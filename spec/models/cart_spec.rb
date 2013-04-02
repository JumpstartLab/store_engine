require 'spec_helper'

describe Cart do
  context 'new' do
    it 'has items' do
      product = FactoryGirl.create(:product)
      session = {}
      session[:cart] = {product.id => '2'}
      cart = Cart.new(session[:cart])
      expect(cart.session).to eq ({product.id => '2'})
    end
  end
end
