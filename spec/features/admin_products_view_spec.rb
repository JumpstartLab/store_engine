require 'spec_helper'

describe 'the admin products view', type: :feature do

  before(:each) do
     #@company = Company.create(name: "Jumpstart Lab")
     #number_a = @company.phone_numbers.create(number: '1025968152')
     #number_b = @company.phone_numbers.create(number: '9871627211')
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

  #   it 'should have a delete link for each phone number' do
  #     visit company_path(@company)
  #     @company.phone_numbers.each do |phone_number|
  #       expect(page).to have_link('delete', href: company_phone_number_path(@company, phone_number))
  #     end
  #   end

  #   it 'should have an add phone number link' do
  #     visit company_path(@company)
  #     expect(page).to have_link('Add a Phone Number', href: new_company_phone_number_path(@company))
  #   end

  #   it 'should display each of the phone numbers' do
  #     visit company_path(@company)
  #     @company.phone_numbers.each do |phone_number|
  #       expect(page).to have_selector('li', text: phone_number.number)
  #     end
  #   end

  #   it 'should show the person including the new number after creating a phone number' do
  #     visit new_company_phone_number_path(@company)
  #     fill_in 'phone_number_number', with: '15098170'
  #     click_button 'Create Phone number'
  #     expect(current_path).to eq(company_path(@company))
  #   end
  # end
end
