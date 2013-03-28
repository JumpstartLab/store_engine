require 'spec_helper'

describe 'the admin products view', type: :feature do
  it 'should have a title' do
    visit admin_products_path
    expect(page).to have_selector('h1', text: 'Products')
  end

  it 'should have a create product button' do
    visit admin_products_path
    expect(page).to have_button('Create Product')
  end
end
