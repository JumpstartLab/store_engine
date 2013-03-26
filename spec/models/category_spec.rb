require File.dirname(__FILE__) + '/../spec_helper'

describe Category do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:category)).to be_valid
  end

  it 'is invalid without a title' do
    expect(FactoryGirl.build(:category, title: '')).to_not be_valid
  end

  it 'is invalid if title already exists (case insensitive)' do
    FactoryGirl.create(:category, title: 'dark MATTER')
    expect(FactoryGirl.build(:category)).to_not be_valid
  end
end
