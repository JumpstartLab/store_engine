require File.dirname(__FILE__) + '/../spec_helper'

describe Product do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:product)).to be_valid
  end

  it 'is invalid without a title' do
    expect(FactoryGirl.build(:product, title: '')).to_not be_valid
  end

  it 'is invalid without a description' do
    expect(FactoryGirl.build(:product, description: '')).to_not be_valid
  end

  it 'is invalid if title already exists (case insensitive)' do
    FactoryGirl.create(:product)
    product = FactoryGirl.build(:product)
    expect(product.valid?).to be_false
  end

  it 'is invalid without a price' do
    expect(FactoryGirl.build(:product, price: nil)).to_not be_valid
  end

  it 'is invalid without a price greater than 0' do
    expect(FactoryGirl.build(:product, price: 0)).to_not be_valid
  end

  it 'is only valid with two or less decimal points' do
    expect(FactoryGirl.build(:product, price: 0.123)).to_not be_valid
    expect(FactoryGirl.build(:product, price: 0.10)).to be_valid
    expect(FactoryGirl.build(:product, price: 0.1)).to be_valid
    expect(FactoryGirl.build(:product, price: 2)).to be_valid
  end

  it 'is invalid without a status' do
    expect(FactoryGirl.build(:product, status: nil)).to_not be_valid
  end

  it 'is invalid with a status other than active or retired' do
    expect(FactoryGirl.build(:product, status: 'active')).to be_valid
    expect(FactoryGirl.build(:product, status: 'retired')).to be_valid
    expect(FactoryGirl.build(:product, status: 'something')).to_not be_valid
  end

  it 'has the ability to be assigned to multiple categories' do
    nicknacks = FactoryGirl.create(:category, title: 'nicknacks')
    superheroes = FactoryGirl.create(:category, title: 'superheroes')
    product = FactoryGirl.create(:product, categories: [nicknacks, superheroes])
    expect(product.categories.count).to eq 2
  end

  it "includes Paperclip correctly" do
    example = Product.new :image => File.new(Rails.root + 'spec/fixtures/images/rails.png')
    expect(example.image_file_name).to eq 'rails.png'
  end

  describe '.retire' do
    context 'on an active product' do
      it 'sets the status from active to retired' do
        product = FactoryGirl.create(:product, status: 'active')
        product.retire
        expect(product.status).to eq 'retired'
      end
    end
  end

  describe '.activate' do
    context 'on a retired product' do
      it 'sets the statusto active' do
        product = FactoryGirl.create(:product, status: 'retired')
        product.activate
        expect(product.status).to eq 'active'
      end
    end
  end

end
