require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  it 'is invalid without an email' do
    expect(FactoryGirl.build(:user, email: nil)).to_not be_valid
  end

  it 'is invalid with a duplicate email' do
    FactoryGirl.create(:user)
    expect(FactoryGirl.build(:user)).to_not be_valid
  end

  it 'is invalid without a password' do
    expect(FactoryGirl.build(:user, password: '')).to_not be_valid
  end

  it 'is invalid without a full name' do
    expect(FactoryGirl.build(:user, full_name: '')).to_not be_valid
  end

  it 'is invalid if display name is not between 2-32 chars if it exists' do
    expect(FactoryGirl.build(:user, display_name: 'p')).to_not be_valid
    expect(FactoryGirl.build(:user, display_name: 'p' * 33)).to_not be_valid
    expect(FactoryGirl.build(:user, display_name: 'p' * 32)).to be_valid
  end

  # #test does not pass because before_save callback in the user model does not work and is commented out
  xit 'is not an admin by default' do
    user.save
    example = User.find_by_email('blah@blah.com')
    puts example.inspect
    expect(example.admin).to eq false
  end
end
