require 'spec_helper'

describe 'the admin products view', type: :feature do
  before(:each) do
    FactoryGirl.create(:admin)
    visit login_path
    fill_in 'sessions_email', with: 'logan@gmail.com'
    fill_in 'sessions_password', with: 'password'
    click_button 'Login'
  end

  it 'should have a title' do
    visit admin_products_path
    expect(page).to have_selector('h1', text: 'Products')
  end

  it 'should have a create product button' do
    visit admin_products_path
    expect(page).to have_button('Create Product')
  end
end
