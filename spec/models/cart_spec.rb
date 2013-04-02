require 'spec_helper'

describe Cart do
  context 'new' do
    it 'has items' do
      product = FactoryGirl.build(:product)
      product2 = FactoryGirl.build(:product, title: 'something')
      session = {}
      session[:cart] = {product.id => '2', product2.id=>'3'}
      cart = Cart.new(session)
      puts "$$$$"
      puts cart.inspect
      expect(cart.count).to eq 2
    end
  end
end
