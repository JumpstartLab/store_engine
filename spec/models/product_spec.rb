require 'spec_helper'

describe Product do

  it "should have price attribute" do
    #subject.price.should be_kind_of Money
    Product.new.price.should be_kind_of Money
  end
end
