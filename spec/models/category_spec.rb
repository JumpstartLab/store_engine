require 'spec_helper'

describe Category do
  let(:category) { Fabricate(:category) }
  let(:product) { Fabricate(:product) }
  let(:products) { [product, Fabricate(:product)] }

end
