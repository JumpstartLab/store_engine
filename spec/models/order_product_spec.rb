require 'spec_helper'

describe OrderProduct do
  context "#subtotal" do
    let(:order) { Fabricate :order }
    let(:product1) { Fabricate :product }
    let(:product2) { Fabricate :product }
  end
end
