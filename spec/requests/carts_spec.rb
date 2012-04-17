require 'spec_helper'

describe "Carts" do
  describe "GET /cart" do
    let(:cart) {FactoryGirl.build(:cart)}
    pending it "works! (now write some real specs)" do
      get cart_path(cart)
      response.status.should be(200)
    end
  end
end
