require 'spec_helper'

feature 'Creating Products' do
  let(:submit) { 'Create Product' }

  before do
    sign_in FactoryGirl.create(:admin_user)
    @sample_category = FactoryGirl.create(:category, name: "Toys")
    visit new_category_product_path(@sample_category)
  end

  scenario 'new products page contains the correct form' do
    expect(page).to have_selector('h2', text: 'Add a new product')
    expect(page).to have_field('product_name')
    expect(page).to have_field('product_description')
    expect(page).to have_field('product_url')
  end

  scenario 'add a new product' do
    fill_in 'product_name',         with: 'Sample Product'
    fill_in 'product_description',  with: 'Lorem ipsum' * 30
    fill_in 'product_url',          with: 'http://www.example.com/'

    expect { click_button submit }.to change(Product, :count).by(1)
    expect(page).to have_content('Product successfully created')
    expect(page).to have_content('Sample Product')
    expect(page).to have_content('Lorem ipsum')
    expect(page).to have_content('http://www.example.com/')
  end


end