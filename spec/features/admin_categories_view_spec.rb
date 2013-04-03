require 'spec_helper'

describe 'the admin categories view', type: :feature do
  before(:each) do
    FactoryGirl.create(:admin)
    visit login_path
    fill_in 'sessions_email', with: 'logan@gmail.com'
    fill_in 'sessions_password', with: 'password'
    click_button 'Login'
    visit admin_categories_path
  end

  it 'should have a title' do
    expect(page).to have_selector('h1', text: 'Categories')
  end

  it 'should have a create category button' do
     expect(page).to have_button('Create Category')
  end
  context 'when a category exists' do
    before(:each) do
      click_button "Create Category"
      fill_in 'Title', with: 'mah things'
      click_button "Create Category"
    end

    it 'creates a new category with valid input' do
      expect(current_path).to eq admin_categories_path
    end

    it 'rejects invalid category input' do
      click_button "Create Category"
      fill_in 'Title', with: 'mah things'
      click_button "Create Category"
      expect(page).to have_content "has already been taken"
    end

    it 'edits a category with valid input' do
      click_link "Edit"
      fill_in "Title", with: 'gooey'
      click_button "Create Category"
      expect(current_path).to eq admin_categories_path
    end
  end
end
