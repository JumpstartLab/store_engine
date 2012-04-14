require 'spec_helper'

describe Address do

  let(:user) { FactoryGirl.create(:user) }
  before(:each) do
    @attr = {
      city: "Washington",
      state: "DC",
      zip_code: 20001,
      street_1: "1445 New York Ave, NW",
      street_2: "Second Floor",
      user_id: user.id
    }
  end

  it "creates a new product given valid attributes" do
    Address.create!(@attr)
  end

  it "requires a user id" do
    no_city_product = Address.new(@attr.merge(user_id: ""))
    no_city_product.should_not be_valid
  end

  it "requires a city" do
    no_city_product = Address.new(@attr.merge(city: ""))
    no_city_product.should_not be_valid
  end

  it "requires a street" do
    no_city_product = Address.new(@attr.merge(street_1: ""))
    no_city_product.should_not be_valid
  end

  describe "state" do
    it "requires a state" do
      no_state_product = Address.new(@attr.merge(state: ""))
      no_state_product.should_not be_valid
    end

    it "rejects states with less than two letters" do
      no_state_product = Address.new(@attr.merge(state: "f"))
      no_state_product.should_not be_valid
    end

    it "rejects a state with more than two letters" do
      no_state_product = Address.new(@attr.merge(state: "f"))
      no_state_product.should_not be_valid
    end
  end

  describe "zip" do
    it "requires a zip that is five numbers" do
      no_zip_product = Address.new(@attr.merge(zip_code:"4523"))
      no_zip_product.should_not be_valid
    end

    it "requires a zip that only has numbers in it" do
      no_zip_product = Address.new(@attr.merge(zip_code:"4d5f3"))
      no_zip_product.should_not be_valid
    end
  end


  # it "requires a description" do
  #   no_description_product = Product.new(@attr.merge(description: ""))
  #   no_description_product.should_not be_valid
  # end

  # it "has a price that is a number" do
  #   non_numeric_product = Product.new(@attr.merge(price: "hello"))
  #   non_numeric_product.should_not be_valid
  # end

  # it "has a price greater than 0" do
  #   non_numeric_product = Product.new(@attr.merge(price: -3))
  #   non_numeric_product.should_not be_valid
  # end

  # it 'rejects duplicate titles' do
  #   Product.create!(@attr)
  #   product_with_duplicate_title = Product.new(@attr)
  #   product_with_duplicate_title.should_not be_valid
  # end
end